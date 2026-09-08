//
//  ReadingSessionViewModel.swift
//  Waraq
//
//  Created by Ammar Saber on 31/08/2026.
//

import Foundation
import SwiftData

@Observable
final class ReadingSessionViewModel {
    let book: Book
    private let modelContext: ModelContext

    init(book: Book, modelContext: ModelContext) {
        self.book = book
        self.modelContext = modelContext
    }
    
    private var session: ReadingSession?

    private(set) var startDate: Date?
    private(set) var pauseDate: Date?

    // subtracted from duration so pause time doesn't count as reading time
    private var totalPausedDuration: TimeInterval = 0

    // how long has this session really been going
    // read live by ElapsedTimeView inside a TimelineView
    var duration: TimeInterval {
        guard let startDate else { return 0 }
        let endPoint = pauseDate ?? .now

        return endPoint.timeIntervalSince(startDate) - totalPausedDuration
    }

    // called from "Start" button
    func start() {
        guard pauseDate == nil else { return }

        startDate = .now
        totalPausedDuration = 0

        let readingSession = ReadingSession(book: book)
        session = readingSession
        modelContext.insert(readingSession)
    }

    // called right before the end-page alert opens
    func pause() {
        pauseDate = .now
    }

    // called when the end-page alert is canceled
    func resume() {
        guard let pauseDate else { return }

        let now = Date.now
        totalPausedDuration += now.timeIntervalSince(pauseDate)

        self.pauseDate = nil
    }

    // called when the end-page alert is confirmed with a valid page
    func end(atPage endPage: Int) {
        guard let session else { return }
        session.endDate = .now
        session.endPage = endPage

        book.currentPage = endPage

        startDate = nil
        pauseDate = nil
        totalPausedDuration = 0

        self.session = nil
    }

    // // called from "Cancel" on the main session screen, not the alert
    func cancel() {
        guard let session else { return }

        pauseDate = nil
        startDate = nil
        totalPausedDuration = 0

        modelContext.delete(session)
        self.session = nil
    }
}
