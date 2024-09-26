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
    var title: String
    var notes: String
    var date: Date?
    var isCompleted: Bool
    
    init(title: String = "New Task", notes: String = "", date: Date? = nil, isCompleted: Bool = false) {
        self.title = title
        self.notes = notes
        self.date = date
        self.isCompleted = isCompleted
    }
}
