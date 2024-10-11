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
            HStack() {
                Text(session.completedTask?.title ?? "No Task")
                    .lineLimit(1)
                Spacer()
                Text(formatSessionDuration(session.duration))
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            Text("\(session.createdAt.formatted(.dateTime.minute().hour())) - \(session.createdAt.addingTimeInterval(TimeInterval(session.duration)).formatted(.dateTime.minute().hour())), \(session.createdAt.formatted(.dateTime.day().weekday().month()))")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
    
    private func formatSessionDuration(_ duration: TimeInterval) -> String {
        if duration >= 3600 {
            let hours: Int = Int(duration / 3600)
            return "\(hours) hours"
        } else if duration >= 60 {
            let minutes: Int = Int(duration / 60)
            return "\(minutes) min"
        } else {
            return "\(Int(duration)) sec"
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
