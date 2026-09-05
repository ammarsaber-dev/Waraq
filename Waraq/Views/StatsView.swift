//
//  StatsView.swift
//  Waraq
//
//  Created by Ammar Saber on 01/09/2026.
//

import SwiftUI
import SwiftData

struct StatsView: View {
    @Query private var books: [Book]
    @Query private var sessions: [ReadingSession]

    var body: some View {
        NavigationStack {
            List {
                StatRowView(label: "Pages read", value: "\(totalPagesRead)")
                StatRowView(label: "Time reading", value: formattedDuration)
                StatRowView(label: "Books finished", value: "\(finishedCount)")
                StatRowView(label: "Currently reading", value: "\(readingCount)")
            }
            .navigationTitle("Stats")
        }
    }

    private var totalPagesRead: Int {
        books.reduce(0) { $0 + $1.currentPage }
    }

    private var totalTimeReading: TimeInterval {
        sessions.reduce(0) { $0 + ($1.duration ?? 0) }
    }

    private var finishedCount: Int {
        books.filter { $0.status == .finished }.count
    }

    private var readingCount: Int {
        books.filter { $0.status == .reading }.count
    }
    
    private var formattedDuration: String {
        Duration.seconds(totalTimeReading)
            .formatted(.units(allowed: [.hours, .minutes], width: .abbreviated))
    }
}

struct StatRowView: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    StatsView()
}
