//
//  TaskListCellView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 26.09.2024.
//

import SwiftUI

struct TaskListCellView: View {
    var task: Task
    var action: (Task) -> Void
    
    var body: some View {
        HStack {
            Button {
                action(task)
            } label: {
                Image(systemName: task.isCompleted ? "circle.inset.filled" : "circle")
                    .renderingMode(.original)
                    .imageScale(.large)
                    .foregroundStyle(task.isCompleted ? Color.accentColor : Color.secondary)
            }
            .buttonStyle(.plain)
            
            VStack(alignment: .leading) {
                Text(task.title)
                if !task.notes.isEmpty {
                    Text(task.notes)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
        }
    }
}

#Preview {
    TaskListCellView(task: Task(title: "New Task", notes: "", date: nil, isCompleted: false)) { task in
        task.isCompleted.toggle()
    }
}
