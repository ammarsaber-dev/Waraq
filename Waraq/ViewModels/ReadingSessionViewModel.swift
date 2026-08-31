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
    enum State {
        case idle
        case running
    }

    private(set) var state: State = .idle
    private(set) var elapsed: TimeInterval = 0
    
    private var timer: Timer?
    private var sessionStartTime: Date?
    private var accumulatedBeforePause: TimeInterval = 0
    private var session: ReadingSession?
    

    let book: Book
    private let modelContext: ModelContext

    
    init(book: Book, modelContext: ModelContext) {
        self.book = book
        self.modelContext = modelContext
    }
    
    func start() {
        let newSession = ReadingSession(book: book)
        modelContext.insert(newSession)
        session = newSession
        
        sessionStartTime = .now
        accumulatedBeforePause = 0
        state = .running
        
        elapsed = 0
        startTicking()
    }
    
    func end(atPage endPage: Int) {
        session?.endDate = .now
        session?.endPage = endPage
        book.currentPage = endPage
        reset()
    }
    
    // cancels the timer (linked to the button)
    func cancel() {
        stopTicking()
        if let session {
            modelContext.delete(session)
        }
        reset()
    }
    
    func pauseForEnding() {
        accumulatedBeforePause = elapsed
        stopTicking()
    }
    
    // called on canceling the alert (resumes the timer from when accumulatedBeforePause ended)
    func resumeAfterCancelingEnd() {
        guard state == .running else { return }
        sessionStartTime = .now.addingTimeInterval(-accumulatedBeforePause)
        startTicking()
    }
    
    // starts the timer from when sessionStartTime started
    private func startTicking() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                    guard let self, let sessionStartTime else { return }
                    self.elapsed = Date.now.timeIntervalSince(sessionStartTime)
                }
    }
    
    // stops the timer
    private func stopTicking() {
        timer?.invalidate()
        timer = nil
    }
    
    
    // called on canceling the timer
    private func reset() {
        stopTicking()
        state = .idle
        elapsed = 0
        session = nil
        sessionStartTime = nil
        accumulatedBeforePause = 0
    }
}
