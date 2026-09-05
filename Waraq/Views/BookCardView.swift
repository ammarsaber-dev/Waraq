//
//  BookCardView.swift
//  Waraq
//
//  Created by Ammar Saber on 29/08/2026.
//

import SwiftUI

struct BookCardView: View {
    let book: Book
    let dailyGoal: DailyGoal?

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.author)
                    .font(.footnote)
            }

            Spacer()

            CircularProgressView(
                progress: book.progress,
                strokeWidth: 5,
                color: book.status.color
            )
            .frame(width: 50, height: 50)
            .overlay(alignment: .topTrailing) {
                if let dailyGoal {
                    Image(
                        systemName: dailyGoal.isAchieved
                            ? "checkmark.circle.fill" : "target"
                    )
                    .font(.caption2)
                    .foregroundStyle(dailyGoal.isAchieved ? .green : .blue)
                    .background(.background, in: Circle())
                    .offset(x: 2, y: -4)
                }
            }
        }
    }
}

#Preview {
    let book = Book(title: "Waraq", author: "Ammar Saber", totalPages: 120)

    return BookCardView(
        book: book,
        dailyGoal: .init(targetBook: book, targetPages: 50)
    )
}
