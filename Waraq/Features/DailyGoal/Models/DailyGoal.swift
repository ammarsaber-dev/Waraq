//
//  DailyGoal.swift
//  Waraq
//
//  Created by Ammar Saber on 03/09/2026.
//

import Foundation
import SwiftData

@Model
final class DailyGoal {
    var targetBook: Book
    var goalDate: Date
    var startingPage: Int
    var targetPages: Int {
        didSet {
            targetPages = max(targetPages, 0)
        }
    }
    
    init(targetBook: Book, targetPages: Int, goalDate: Date = .now) {
        self.targetBook = targetBook
        self.targetPages = max(targetPages, 0)
        self.goalDate = goalDate
        self.startingPage = targetBook.currentPage
    }
}

extension DailyGoal {
    var pagesRead: Int {
        targetBook.currentPage - startingPage
    }

    var isAchieved: Bool {
        pagesRead >= targetPages
    }
}


extension [DailyGoal] {
    func today(for book: Book) -> DailyGoal? {
        first { $0.targetBook == book && Calendar.current.isDate(.now, inSameDayAs: $0.goalDate) }
    }
}
