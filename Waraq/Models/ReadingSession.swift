//
//  ReadingSession.swift
//  Waraq
//
//  Created by Ammar Saber on 31/08/2026.
//

import Foundation
import SwiftData

@Model
final class ReadingSession {
    var startDate: Date
    var endDate: Date?
    var startPage: Int
    var endPage: Int?
    var book: Book?

    init(book: Book) {
        self.book = book
        self.startDate = .now
        self.startPage = book.currentPage
    }
}

extension ReadingSession {
    var pagesRead: Int? {
        guard let endPage else { return nil }
        return max(endPage - startPage, 0)
    }

    var duration: TimeInterval? {
        guard let endDate else { return nil }
        return endDate.timeIntervalSince(startDate)
    }
}
