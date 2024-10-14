//
//  CreateTaskDetailView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 26.09.2024.
//

import SwiftData
import SwiftUI

struct CreateTaskDetailView: View {
    var task: Task?
    
    @Environment(\.modelContext) var modelContext
    @Query var taskCategories: [TaskCategory]
    
    @State private var title: String = "New Task"
    @State private var notes: String = ""
    @State private var category: TaskCategory?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Notes", text: $notes)
                Picker("Category", selection: $category) {
                    Text("None").tag(nil as TaskCategory?)
                    ForEach(taskCategories) { category in
                        Text(category.name).tag(category as TaskCategory?)
                    }
                }
            }
            .navigationTitle("Task")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if let task {
                    title = task.title
                    notes = task.notes
                    category = task.category
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let task {
                            modelContext.insert(task)
                        } else {
                            let task = Task(title: title, notes: notes, isCompleted: false)
                            task.category = category
                            modelContext.insert(task)
                        }
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CreateTaskDetailView(task: Task(title: "New Task", notes: "", isCompleted: false))
}
