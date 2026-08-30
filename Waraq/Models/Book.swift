//
//  Book.swift
//  Waraq
//
//  Created by Ammar Saber on 29/08/2026.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Book {
    var title: String
    var author: String
    var totalPages: Int
    var dateAdded: Date
    
    
    var currentPage: Int {
        didSet {
            currentPage = min(max(currentPage, 0), totalPages)
        }
    }
    
    init(title: String, author: String, totalPages: Int, currentPage: Int = 0) {
        self.title = title
        self.author = author
        self.totalPages = max(totalPages, 1)
        self.currentPage = 0
        self.dateAdded = .now
        self.currentPage = min(max(currentPage, 0), self.totalPages)
    }
}


extension Book {
    enum ReadingStatus: String {
        case notStarted = "not started"
        case reading = "reading"
        case finished = "finished"
    }
    
    var status: ReadingStatus {
        if currentPage == 0 { return .notStarted }
        if currentPage >= totalPages { return .finished }
        
        return .reading
    }
    
    var progress: Double {
        guard totalPages > 0 else { return 0 }
        return Double(currentPage) / Double(totalPages)
    }
}


extension Book.ReadingStatus {
    var color: Color {
        switch self {
        case .notStarted: .gray
        case .reading: .blue
        case .finished: .green
        }
    }
}
