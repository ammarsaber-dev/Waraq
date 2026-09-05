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

    private var averageSessionLength: TimeInterval {
        guard !sessions.isEmpty else { return 0 }

        return totalTimeReading / Double(sessions.count)
    }

    private var readingStreak: Int {
        var streak = 0
        var currentDate: Date = hadSession(on: .now) ? .now : (Calendar.current.date(byAdding: .day, value: -1, to: .now) ?? .now)

        while hadSession(on: currentDate) {
            streak += 1
            guard let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) else {
                return streak
            }
            currentDate = previousDay
        }

        return streak
    }

    private var mostReadBook: Book? {
        books.max { $0.progress < $1.progress }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    OverallProgressSection(
                        totalPagesRead: totalPagesRead,
                        totalTimeReading: totalTimeReading,
                        finishedCount: finishedCount,
                        readingCount: readingCount
                    )

                    ReadingHabitsSection(
                        streak: readingStreak,
                        averageSessionLength: averageSessionLength,
                        mostReadBook: mostReadBook,
                        sessionCount: sessions.count
                    )
                }
                .padding()
            }
            .navigationTitle("Stats")
        }
    }

    private func hadSession(on date: Date) -> Bool {
        sessions.contains { session in
            Calendar.current.isDate(session.startDate, inSameDayAs: date)
        }
    }
}

struct OverallProgressSection: View {
    let totalPagesRead: Int
    let totalTimeReading: TimeInterval
    let finishedCount: Int
    let readingCount: Int

    private var formattedTime: String {
        Duration.seconds(totalTimeReading)
            .formatted(
                .units(allowed: [.hours, .minutes], width: .abbreviated)
            )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Overall progress")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 10
            ) {
                MetricCardView(label: "Pages read", value: "\(totalPagesRead)")
                MetricCardView(label: "Time reading", value: formattedTime)
            }

            BooksSummaryCardView(
                finishedCount: finishedCount,
                readingCount: readingCount
            )
        }
    }
}

struct BooksSummaryCardView: View {
    let finishedCount: Int
    let readingCount: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Books")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(finishedCount) finished")
                        .font(.title3.weight(.medium))
                    Text("· \(readingCount) reading")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            Image(systemName: "books.vertical")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct MetricCardView: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title3.weight(.medium))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct ReadingHabitsSection: View {
    let streak: Int
    let averageSessionLength: TimeInterval
    let mostReadBook: Book?
    let sessionCount: Int

    private var formattedAverage: String {
        Duration.seconds(averageSessionLength)
            .formatted(.units(allowed: [.minutes], width: .abbreviated))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Reading habits")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            VStack(spacing: 8) {
                HabitRowView(
                    icon: "flame",
                    iconColor: .orange,
                    label: "Reading streak",
                    value: "\(streak) day\(streak == 1 ? "" : "s")"
                )
                HabitRowView(
                    icon: "clock",
                    iconColor: .secondary,
                    label: "Avg. session",
                    value: formattedAverage
                )

                if let mostReadBook {
                    HabitRowView(
                        icon: "book",
                        iconColor: .secondary,
                        label: "Most read",
                        value: mostReadBook.title
                    )
                }

                HabitRowView(
                    icon: "list.number",
                    iconColor: .secondary,
                    label: "Sessions logged",
                    value: "\(sessionCount)"
                )
            }
        }
    }
}

struct HabitRowView: View {
    let icon: String
    let iconColor: Color
    let label: String
    let value: String

    var body: some View {
        HStack {
            Label {
                Text(label)
            } icon: {
                Image(systemName: icon)
                    .foregroundStyle(iconColor)
            }
            .font(.subheadline)

            Spacer()

            Text(value)
                .font(.subheadline.weight(.medium))
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    StatsView()
        .modelContainer(
            for: [Book.self, ReadingSession.self, DailyGoal.self],
            inMemory: true
        )
}
