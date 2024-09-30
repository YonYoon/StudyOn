//
//  StudyOnApp.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 26.09.2024.
//

import SwiftUI
import SwiftData

@main
struct StudyOnApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Task.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Tasks", systemImage: "list.bullet.circle.fill") {
                    TasksView()
                }
                
                Tab("Study", systemImage: "timer") {
                    StudyView()
                }
            }
            .preferredColorScheme(.dark)
        }
        .modelContainer(sharedModelContainer)
    }
}
