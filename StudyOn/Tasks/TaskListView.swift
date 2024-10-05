//
//  TaskListView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 27.09.2024.
//

import SwiftData
import SwiftUI

struct TaskListView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var tasks: [Task]
    
    init(hideCompleted: Bool) {
        if hideCompleted {
            _tasks = Query(filter: #Predicate<Task> { !$0.isCompleted }, animation: .default)
        } else {
            _tasks = Query()
        }
    }
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                NavigationLink {
                    TaskDetailView(task: task)
                } label: {
                    TaskListCellView(task: task, action: taskCompleted)
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    private func taskCompleted(_ task: Task) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].isCompleted.toggle()
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(tasks[index])
            }
        }
    }
}

#Preview {
    TaskListView(hideCompleted: false)
        .modelContainer(for: Task.self, inMemory: true)
}
