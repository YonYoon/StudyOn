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
    var duration: Int
    var completedTask: Task?
    var type: Stage
    
    init(duration: Int, completedTask: Task?, type: Stage) {
        self.duration = duration
        self.completedTask = completedTask
        self.type = type
    }
}

enum Stage: String, Hashable, Codable {
    case focus = "Focus"
    case rest = "Rest"
}
