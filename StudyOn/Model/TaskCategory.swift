//
//  TaskCategory.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 14.10.2024.
//

import Foundation
import SwiftData

@Model
final class TaskCategory {
    var name: String = "Category"
    @Relationship(deleteRule: .cascade, inverse: \Task.category) var tasks: [Task]? = [Task]()
    
    init(name: String) {
        self.name = name
    }
}
