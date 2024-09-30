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
    @State private var hour = 0
    @State private var minute = 25
    @State private var second = 0
    @State private var stage = Stage.focus
    @State private var selectedTask: Task? = nil
    
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
                    Section("Timer") {
                        HStack {
                            Picker("Duration", selection: $hour) {
                                ForEach(0..<24) { hour in
                                    Text("\(hour)")
                                }
                            }
                            .pickerStyle(.wheel)
                            Text("hours")
                            
                            Picker("Duration", selection: $minute) {
                                ForEach(0..<60) { hour in
                                    Text("\(hour)")
                                }
                            }
                            .pickerStyle(.wheel)
                            Text("min")
                            
                            Picker("Duration", selection: $second) {
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
                }
                
                Button {
                    // start timer
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
