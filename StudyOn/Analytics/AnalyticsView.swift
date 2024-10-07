//
//  AnalyticsView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 06.10.2024.
//

import SwiftData
import SwiftUI

struct AnalyticsView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var sessions: [Session]
    
    var body: some View {
        NavigationStack {
            Group {
                if sessions.isEmpty {
                    ContentUnavailableView("No Sessions", systemImage: "text.document.fill")
                } else {
                    Form {
                        Section("Sessions") {
                            List {
                                ForEach(sessions) { session in
                                    SessionListCellView(session: session)
                                }
                                .onDelete(perform: deleteItems)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Analytics")
            .toolbar {
                if !sessions.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(sessions[index])
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Session.self, configurations: config)
    

    let session = Session(
        duration: 1500,
        completedTask: Task(title: "Practice SwiftUI", notes: "Make an app", date: .now, isCompleted: true),
        type: .focus,
        createdAt: .now
    )
    container.mainContext.insert(session)
    
    return AnalyticsView()
        .preferredColorScheme(.dark)
        .modelContainer(container)
//        .modelContainer(for: Session.self, inMemory: true)
}
