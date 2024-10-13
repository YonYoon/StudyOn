//
//  Task.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 26.09.2024.
//

import Foundation
import SwiftData

@Model
final class Task {
    var title: String = "New Task"
    var notes: String = ""
    var createdAt: Date = Date()
    var isCompleted: Bool = false
    var session: Session? = nil
    
    init(title: String, notes: String, isCompleted: Bool) {
        self.title = title
        self.notes = notes
        self.isCompleted = isCompleted
    }
}
