//
//  BookHeaderView.swift
//  Waraq
//
//  Created by Ammar Saber on 07/09/2026.
//

import SwiftUI

struct BookHeaderView: View {
    let book: Book

    var body: some View {
        VStack(spacing: 4) {
            Text(book.title)
                .font(.title2.weight(.bold))
                .fontWidth(.expanded)
                .multilineTextAlignment(.center)
            
            Text(book.author)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(book.status.rawValue.capitalized)
                .font(.caption.weight(.semibold))
                .foregroundStyle(book.status.color)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(book.status.color.opacity(0.15), in: Capsule())
        }
    }
}
