//
//  SessionListCellView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 07.10.2024.
//

import SwiftUI

struct SessionListCellView: View {
    let session: Session
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(session.type == .focus ? "Focus" : "Break")
                .font(.caption)
                .foregroundStyle(session.type == .focus ? .green : .red)
            Text(session.completedTask?.title ?? "No Task")
            Text("\(session.createdAt.formatted(.dateTime.minute().hour())) - \(session.createdAt.addingTimeInterval(TimeInterval(session.duration)).formatted(.dateTime.minute().hour())), \(session.createdAt.formatted(.dateTime.day().weekday().month()))")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SessionListCellView(session:
                            Session(
                                duration: 1500,
                                completedTask: Task(title: "Practice SwiftUI", notes: "Make an app", date: .now, isCompleted: true),
                                type: .focus,
                                createdAt: .now
                            )
    )
}
