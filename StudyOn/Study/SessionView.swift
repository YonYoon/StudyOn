//
//  SessionView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 04.10.2024.
//

import Combine
import SwiftData
import SwiftUI

struct SessionView: View {
    @Environment(\.modelContext) var modelContext
    
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.scenePhase) var scenePhase
    
    @State var remainingFocusTime: TimeInterval
    let totalFocusTime: TimeInterval
    @SceneStorage("SessionView.lastMomentTimerFired") private var lastMomentTimerFired: Date?
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var cancellable: Cancellable? = nil
    @State private var isTimerRunning = false
    
    @Binding var task: Task?
    let type: Stage
    
    init(focusTime: TimeInterval, task: Binding<Task?>, type: Stage) {
        self.remainingFocusTime = focusTime
        self.totalFocusTime = focusTime
        self._task = task
        self.type = type
    }
    
    var body: some View {
        VStack {
            Text(DateComponentsFormatter().string(from: remainingFocusTime) ?? "Error")
                .font(.system(size: 75, weight: .bold, design: .monospaced))
                .onReceive(timer, perform: { _ in
                    if remainingFocusTime > 0 {
                        remainingFocusTime -= 1
                    } else {
                        endSession()
                        // TODO: Play sound
                        // TODO: Continue session with extra time
                    }
                })
                .onChange(of: scenePhase) {
                    if scenePhase == .active {
                        let timePassed = Date.now.timeIntervalSince(lastMomentTimerFired!)
                        remainingFocusTime -= timePassed
                    } else if scenePhase == .background {
                        lastMomentTimerFired = .now
                    }
                }
            
            if let task {
                TaskListCellView(task: task) { task in
                    task.isCompleted.toggle()
                }
                .padding(.top)
                .padding(.bottom, 50)
            }
            
            HStack(spacing: 75) {
                Button {
                    endSession()
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .frame(width: 50, height: 50)
                        .font(.title2)
                }
                .buttonBorderShape(.circle)
                .buttonStyle(.bordered)
                .tint(.orange)
                
                if isTimerRunning {
                    TimerButton(action: stopTimer, stage: .stop)
                } else {
                    TimerButton(action: startTimer, stage: .start)
                }
            }
        }
        .onAppear {
            startTimer()
        }
    }
    
    private func stopTimer() {
        cancellable?.cancel()
        isTimerRunning = false
    }
    
    private func startTimer() {
        isTimerRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
        cancellable = timer.connect()
    }
    
    private func endSession() {
        stopTimer()
        modelContext.insert(
            Session(
                duration: Int(totalFocusTime - remainingFocusTime - 1),
                completedTask: task,
                type: type,
                createdAt: .now.addingTimeInterval(-(totalFocusTime - remainingFocusTime - 1))
            )
        )
        task = nil
        dismiss()
    }
}

#Preview {
    SessionView(
        focusTime: 25*60,
        task: .constant(
            Task(
                title: "Solve 5 problems",
                notes: "Do not ask for help and do not look at the solution",
                date: nil,
                isCompleted: false
            )
        ),
        type: .focus
    )
    .preferredColorScheme(.dark)
}

struct TimerButton: View {
    enum TimerButtonStage {
        case start, stop
    }
    
    var action: () -> Void
    var stage: TimerButtonStage
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: stage == .start ? "play.fill" : "stop.fill")
                .imageScale(.large)
                .frame(width: 50, height: 50)
                .font(.title3)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .tint(stage == .start ? .green : .red)
    }
}
