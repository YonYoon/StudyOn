//
//  AnalyticsView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 06.10.2024.
//

import SwiftData
import SwiftUI

struct AnalyticsView: View {
    @Query private var sessions: [Session]
    
    var body: some View {
        NavigationStack {
            Group {
                if sessions.isEmpty {
                    ContentUnavailableView("No Sessions", systemImage: "text.document.fill")
                } else {
                    Form {
                        Section("Sessions") {
                            List(sessions) { session in
                                Text(session.createdAt.formatted(.dateTime.minute().hour().day().weekday().month()))
                            }
                        }
                    }
                }
            }
            .navigationTitle("Analytics")
        }
    }
}

#Preview {
    AnalyticsView()
        .preferredColorScheme(.dark)
        .modelContainer(for: Session.self, inMemory: true)
}
