//
//  SessionView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 04.10.2024.
//

import Combine
import SwiftUI

struct SessionView: View {
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
                            // TODO: Set to user defined total focus time
                            totalFocusTime = 25 * 60 // 25 minutes
                        }
                    })
                    .font(.system(size: 75, weight: .bold, design: .monospaced))
                Spacer()
            }
            
            if isTimerRunning {
                TimerButton(action: stopTimer, stage: .stop)
            } else {
                TimerButton(action: startTimer, stage: .start)
            }
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
    SessionView(totalFocusTime: 25)
}
