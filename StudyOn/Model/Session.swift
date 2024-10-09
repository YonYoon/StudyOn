//
//  Session.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 29.09.2024.
//

import Foundation
import SwiftData

@Model
final class Session {
    var duration: Int = 0
    @Relationship(inverse: \Task.session) var completedTask: Task? = nil
    var type: Stage = Stage.focus
    var createdAt: Date = Date()
    
    init(duration: Int, completedTask: Task?, type: Stage, createdAt: Date) {
        self.duration = duration
        self.completedTask = completedTask
        self.type = type
        self.createdAt = createdAt
    }
}

enum Stage: String, Hashable, Codable {
    case focus = "Focus"
    case rest = "Rest"
}
