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
    @State private var focusHour: Int = 0
    @State private var focusMinute: Int = 25
    @State private var focusSecond: Int = 0
    
    @State private var breakHour: Int = 0
    @State private var breakMinute: Int = 5
    @State private var breakSecond: Int = 0
    
    @State private var stage: Stage = .focus
    @State private var selectedTask: Task? = nil
    
    @State private var isSessionStarted: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Stages", selection: $stage) {
                    Text(Stage.focus.rawValue).tag(Stage.focus)
                    Text(Stage.rest.rawValue).tag(Stage.rest)
                }
                .pickerStyle(.palette)
                .padding()
                
                Form {
                    if stage == .focus {
                        Section("Timer") {
                            TimerPicker(hours: $focusHour, minutes: $focusMinute, seconds: $focusSecond)
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
                            TimerPicker(hours: $breakHour, minutes: $breakMinute, seconds: $breakSecond)
                        }
                    }
                }
                
                Button("Start session") {
                    isSessionStarted = true
                }
                .fullScreenCover(isPresented: $isSessionStarted) {
                    let hourInSeconds: Int = focusHour * 3600
                    let minutesInSeconds: Int = focusMinute * 60

                    SessionView(totalFocusTime: TimeInterval((hourInSeconds + minutesInSeconds + focusSecond)))
                }
            }
            .navigationTitle("Study")
        }
        .scrollBounceBehavior(.basedOnSize)
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

struct TimerPicker: View {
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int
    
    var body: some View {
        HStack {
            Picker("Hours", selection: $hours) {
                ForEach(0..<24) { hour in
                    Text("\(hour)")
                }
            }
            .pickerStyle(.wheel)
            Text("hours")
            
            Picker("Minutes", selection: $minutes) {
                ForEach(0..<60) { min in
                    Text("\(min)")
                }
            }
            .pickerStyle(.wheel)
            Text("min")
            
            Picker("Seconds", selection: $seconds) {
                ForEach(0..<60) { sec in
                    Text("\(sec)")
                }
            }
            .pickerStyle(.wheel)
            Text("sec")
        }
    }
}
