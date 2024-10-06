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
                                    Text(session.createdAt.formatted(.dateTime.minute().hour().day().weekday().month()))
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
    AnalyticsView()
        .preferredColorScheme(.dark)
        .modelContainer(for: Session.self, inMemory: true)
}
