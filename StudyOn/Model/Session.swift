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
    var duration: DateInterval
    var completedTasks: [Task]
    
    init(duration: DateInterval, completedTasks: [Task]) {
        self.duration = duration
        self.completedTasks = completedTasks
    }
}
