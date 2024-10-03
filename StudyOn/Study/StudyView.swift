//
//  StudyView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 27.09.2024.
//

import SwiftData
import SwiftUI

struct StudyView: View {
    enum Stage: String, Hashable {
        case focus = "Focus"
        case rest = "Rest"
    }
    
    @Query(filter: #Predicate<Task> { !$0.isCompleted }) private var tasks: [Task]
    @State private var focusHour = 0
    @State private var focusMinute = 25
    @State private var focusSecond = 0
    
    @State private var breakHour = 0
    @State private var breakMinute = 5
    @State private var breakSecond = 0
    
    @State private var stage = Stage.focus
    @State private var selectedTask: Task? = nil
    @State private var isSettingsShown = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Stages", selection: $stage) {
                    Text(Stage.focus.rawValue).tag(Stage.focus)
                    Text(Stage.rest.rawValue).tag(Stage.rest)
                }
                .pickerStyle(.palette)
                .padding()
                
                // TODO: Implement working timer
                HStack(alignment: .center) {
                    Spacer()
                    Text("25:00") // Placeholder time
                        .font(.system(size: 75, weight: .bold, design: .monospaced))
                    Spacer()
                }
                
                Form { 
                    Section("Task") {
                        Picker("Choose a task", selection: $selectedTask) {
                            Text("No task").tag(Optional<Task>(nil))
                            ForEach(tasks) { task in
                                Text(task.title).tag(Optional(task))
                            }
                        }
                    }
                }
                
                Button {
                    // TODO: Implement starting timer
                } label: {
                    Text("Start")
                        .frame(width: 50, height: 50)
                        .font(.title3)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                .tint(.green)
                .padding(.bottom, 50)
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
}

#Preview {
    StudyView()
        .modelContainer(for: Task.self, inMemory: true)
        .modelContainer(for: Session.self, inMemory: true)
        .preferredColorScheme(.dark)
}
