//
//  StatsView.swift
//  Waraq
//
//  Created by Ammar Saber on 01/09/2026.
//

import SwiftData
import SwiftUI

struct StatsView: View {
    @Query private var books: [Book]
    @Query private var sessions: [ReadingSession]
    
    private var stats: ReadingStats {
        ReadingStats(books: books, sessions: sessions)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    OverallProgressSection(
                        totalPagesRead: stats.totalPagesRead,
                        totalTimeReading: stats.totalTimeReading,
                        finishedCount: stats.finishedCount,
                        readingCount: stats.readingCount
                    )

                    ReadingHabitsSection(
                        streak: stats.readingStreak,
                        averageSessionLength: stats.averageSessionLength,
                        mostReadBook: stats.mostReadBook,
                        sessionCount: stats.sessionCount
                    )
                }
                .padding()
            }
            .navigationTitle("Stats")
        }
    }
}

#Preview {
    StatsView()
}
