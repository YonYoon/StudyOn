//
//  Session.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 29.09.2024.
//

import Foundation
import SwiftData

protocol Session {
    var duration: Int { get }
}

@Model
final class StudySession: Session {
    var duration: Int
    var completedTask: Task?
    
    init(duration: Int, completedTask: Task?) {
        self.duration = duration
        self.completedTask = completedTask
    }
}

@Model
final class BreakSession: Session {
    var duration: Int
    
    init(duration: Int) {
        self.duration = duration
    }
}
