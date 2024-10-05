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
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                Text(DateComponentsFormatter().string(from: totalFocusTime) ?? "Error")
                    .onReceive(timer, perform: { _ in
                        if totalFocusTime > 0 {
                            totalFocusTime -= 1
                        } else {
                            cancellable?.cancel()
                            isTimerRunning = false
                            dismiss()
                            // TODO: Play sound
                            // TODO: Continue session with extra time
                        }
                    })
                    .font(.system(size: 75, weight: .bold, design: .monospaced))
                Spacer()
            }
            
            HStack(spacing: 75) {
                Button {
                    isTimerRunning = false
                    dismiss()
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
}

#Preview {
    SessionView(totalFocusTime: 25*60)
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
//        .padding(.bottom, 50)
    }
}
