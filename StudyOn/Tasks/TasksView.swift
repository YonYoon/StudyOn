//
//  TasksView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 26.09.2024.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var hideCompleted: Bool = true
    @Query private var tasks: [Task]
    @Query(filter: #Predicate<Task> { !$0.isCompleted }, animation: .default) private var tasksToDo: [Task]

    var body: some View {
        NavigationSplitView {
            TaskListView(hideCompleted: hideCompleted)
            .navigationTitle("Tasks")
            .listStyle(.plain)
            .overlay {
                if tasks.isEmpty || hideCompleted && tasksToDo.isEmpty {
                    ContentUnavailableView("No Tasks", systemImage: "tray")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Task", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Menu("Options", systemImage: "ellipsis.circle") {
                        Button(hideCompleted ? "Show Completed" : "Hide Completed", systemImage: hideCompleted ? "eye" : "eye.slash") {
                            hideCompleted.toggle()
                        }
                    }

                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Task(title: "New Task", notes: "", date: nil, isCompleted: false)
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    TasksView()
        .modelContainer(for: Task.self, inMemory: true)
        .preferredColorScheme(.dark)
}
