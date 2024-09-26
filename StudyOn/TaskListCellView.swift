//
//  TaskListCellView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 26.09.2024.
//

import SwiftUI

struct TaskListCellView: View {
    var task: Task
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button {
                action()
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
    TaskListCellView(task: Task()) {
        print("Action")
    }
}
