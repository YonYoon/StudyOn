//
//  File.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 14.10.2024.
//

import Foundation

import SwiftData
import SwiftUI

struct EditDetailView: View {
    @Bindable var task: Task
    
    @Query private var taskCategories: [TaskCategory]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $task.title)
                TextField("Notes", text: $task.notes)
                Picker("Category", selection: $task.category) {
                    Text("None").tag(nil as TaskCategory?)
                    ForEach(taskCategories) { category in
                        Text(category.name).tag(category as TaskCategory?)
                    }
                }
            }
            .navigationTitle("Task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EditTaskDetailView(task: Task(title: "Title", notes: "Notes", isCompleted: false))
}
