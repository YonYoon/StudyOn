//
//  StudyView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 27.09.2024.
//

import Combine
import SwiftData
import SwiftUI

struct StudyView: View {
    enum Stage: String, Hashable {
        case focus = "Focus"
        case rest = "Rest"
    }
    
    @Query(filter: #Predicate<Task> { !$0.isCompleted }) private var tasks: [Task]
    // TODO: Make timers persistent
    @State private var focusHour = 0
    @State private var focusMinute = 25
    @State private var focusSecond = 0
    @State private var totalFocusTime: TimeInterval = 25 * 60 // 25 minutes
    
    @State private var breakHour = 0
    @State private var breakMinute = 5
    @State private var breakSecond = 0
    
    @State private var stage = Stage.focus
    @State private var selectedTask: Task? = nil
    @State private var isSettingsShown = false
    @State private var isSessionStarted = false
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var cancellable: Cancellable? = nil
    @State private var isTimerRunning = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if isSessionStarted {
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
                } else {
                    Picker("Stages", selection: $stage) {
                        Text(Stage.focus.rawValue).tag(Stage.focus)
                        Text(Stage.rest.rawValue).tag(Stage.rest)
                    }
                    .pickerStyle(.palette)
                    .padding()
                    
                    Form {
                        if stage == .focus {
                            Section("Timer") {
                                HStack {
                                    Picker("Duration", selection: $focusHour) {
                                        ForEach(0..<24) { hour in
                                            Text("\(hour)")
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    Text("hours")
                                    
                                    Picker("Duration", selection: $focusMinute) {
                                        ForEach(0..<60) { hour in
                                            Text("\(hour)")
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    Text("min")
                                    
                                    Picker("Duration", selection: $focusSecond) {
                                        ForEach(0..<60) { hour in
                                            Text("\(hour)")
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    Text("sec")
                                }
                            }
                            
                            Section("Task") {
                                Picker("Choose a task", selection: $selectedTask) {
                                    Text("No task").tag(Optional<Task>(nil))
                                    ForEach(tasks) { task in
                                        Text(task.title).tag(Optional(task))
                                    }
                                }
                            }
                        } else {
                            Section("Timer") {
                                HStack {
                                    Picker("Duration", selection: $breakHour) {
                                        ForEach(0..<24) { hour in
                                            Text("\(hour)")
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    Text("hours")
                                    
                                    Picker("Duration", selection: $breakMinute) {
                                        ForEach(0..<60) { hour in
                                            Text("\(hour)")
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    Text("min")
                                    
                                    Picker("Duration", selection: $breakSecond) {
                                        ForEach(0..<60) { hour in
                                            Text("\(hour)")
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    Text("sec")
                                }
                            }
                        }
                    }
                    
                    Button("Start session") {
                        isSessionStarted = true
                    }
                }
            }
            .navigationTitle("Study")
            .toolbar {
                Button("Settings", systemImage: "gear") {
                    isSettingsShown = true
                }
                .tint(.green)
            }
            .sheet(isPresented: $isSettingsShown) {
                StudySettingsView(focusHour: $focusHour, focusMinute: $focusMinute, focusSecond: $focusSecond, breakHour: $breakHour, breakMinute: $breakMinute, breakSecond: $breakSecond)
            }
        }
        .scrollBounceBehavior(.basedOnSize)
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
    StudyView()
        .modelContainer(for: Task.self, inMemory: true)
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
            Text(stage == .start ? "Start" : "Stop")
                .frame(width: 50, height: 50)
                .font(.title3)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .tint(stage == .start ? .green : .red)
        .padding(.bottom, 50)
    }
}
