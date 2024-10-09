//
//  TaskDetailView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 26.09.2024.
//

import SwiftUI

struct TaskDetailView: View {
    @Bindable var task: Task
    
    var body: some View {
        Form {
            TextField("Title", text: $task.title)
            TextField("Notes", text: $task.notes)
        }
    }
}

#Preview {
    TaskDetailView(task: Task(title: "New Task", notes: "", date: nil, isCompleted: false))
}
