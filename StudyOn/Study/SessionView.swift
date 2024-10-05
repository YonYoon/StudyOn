//
//  SessionView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 04.10.2024.
//

import Combine
import SwiftUI

struct SessionView: View {
    @Environment(\.dismiss) var dismiss
    @State var totalFocusTime: TimeInterval
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var cancellable: Cancellable? = nil
    @State private var isTimerRunning = false
    
    @Binding var task: Task?
    
    var body: some View {
        VStack {
            Text(DateComponentsFormatter().string(from: totalFocusTime) ?? "Error")
                .onReceive(timer, perform: { _ in
                    if totalFocusTime > 0 {
                        totalFocusTime -= 1
                    } else {
                        endSession()
                        // TODO: Play sound
                        // TODO: Continue session with extra time
                    }
                })
                .font(.system(size: 75, weight: .bold, design: .monospaced))
            
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
                    // TODO: Save session in memory
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
            totalFocusTime += 1 // For smoother appearance of timer
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
        totalFocusTime -= 1 // Starting timer feels slow without this
    }
    
    private func endSession() {
        cancellable?.cancel()
        isTimerRunning = false
        dismiss()
        task = nil
    }
}

#Preview {
    SessionView(
        totalFocusTime: 25*60,
        task: .constant(
            Task(
                title: "Solve 5 problems",
                notes: "Do not ask for help and do not look at the solution",
                date: nil,
                isCompleted: false
            )
        )
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
