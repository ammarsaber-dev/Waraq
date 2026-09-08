//
//  BookProgressSummaryView.swift
//  Waraq
//
//  Created by Ammar Saber on 07/09/2026.
//

import SwiftUI

struct BookProgressSummaryView: View {
    let book: Book

    var body: some View {
        VStack(spacing: 12) {
            CircularProgressView(progress: book.progress,
                                 strokeWidth: 8,
                                 color: .green,
                                 percentageFont: .default)
                .frame(width: 200)
            Text("\(book.currentPage) / \(book.totalPages) pages")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}
