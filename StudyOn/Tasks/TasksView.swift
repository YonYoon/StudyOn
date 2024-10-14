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
    
    @State private var isDetailViewPresented = false

    var body: some View {
        NavigationStack {
            TaskListView(hideCompleted: hideCompleted)
            .navigationTitle("Tasks")
            .listStyle(.plain)
            .overlay {
                if tasks.isEmpty || hideCompleted && tasksToDo.isEmpty {
                    ContentUnavailableView("No Tasks", systemImage: "tray")
                }
            }
            .sheet(isPresented: $isDetailViewPresented, content: {
                CreateTaskDetailView()
            })
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
        }
    }

    private func addItem() {
        withAnimation {
            isDetailViewPresented = true
        }
    }
}

#Preview {
    TasksView()
        .modelContainer(for: Task.self, inMemory: true)
        .preferredColorScheme(.dark)
}
