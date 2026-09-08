//
//  ReadingStats.swift
//  Waraq
//
//  Created by Ammar Saber on 08/09/2026.
//

import Foundation

struct ReadingStats {
    let totalPagesRead: Int
    let totalTimeReading: TimeInterval
    let finishedCount: Int
    let readingCount: Int
    let averageSessionLength: TimeInterval
    let readingStreak: Int
    let mostReadBook: Book?
    let sessionCount: Int

    init(books: [Book], sessions: [ReadingSession], calendar: Calendar = .current, now: Date = .now) {
        totalPagesRead = books.reduce(0) { $0 + $1.currentPage }

        totalTimeReading = sessions.reduce(0) { $0 + ($1.duration ?? 0) }

        finishedCount = books.filter { $0.status == .finished }.count

        readingCount = books.filter { $0.status == .reading }.count

        sessionCount = sessions.count

        averageSessionLength = sessions.isEmpty ? 0 : totalTimeReading / Double(sessions.count)

        readingStreak = Self.calculateStreak(sessions: sessions, calendar: calendar, now: now)

        mostReadBook = books.max {
            $0.progress < $1.progress
        }
    }

    private static func calculateStreak(sessions: [ReadingSession], calendar: Calendar, now: Date) -> Int {
        func hadSession(on date: Date) -> Bool {
            sessions.contains {
                calendar.isDate($0.startDate, inSameDayAs: date)
            }
        }

        var streak = 0

        var currentDate = hadSession(on: now) ? now : (calendar.date(byAdding: .day, value: -1, to: now) ?? now)

        while hadSession(on: currentDate) {
            streak += 1

            guard let previousDay = calendar.date(byAdding: .day, value: -1, to: currentDate) else { break }

            currentDate = previousDay
        }

        return streak
    }
}
