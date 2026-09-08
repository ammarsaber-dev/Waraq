//
//  BookListView.swift
//  Waraq
//
//  Created by Ammar Saber on 29/08/2026.
//

import SwiftData
import SwiftUI

struct BookListView: View {
    @Query(sort: \Book.dateAdded, order: .reverse) private var books: [Book]
    @Query private var dailyGoals: [DailyGoal]
    
    @State private var showAddBookView = false

    var body: some View {
        NavigationStack {
            List(books) { book in
                NavigationLink(value: book) {
                    BookCardView(book: book, dailyGoal: dailyGoals.today(for: book))
                }
            }
            .navigationDestination(for: Book.self) { book in
                BookDetailView(book: book)
            }
            .navigationTitle("Books")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add a new book", systemImage: "plus") {
                        showAddBookView.toggle()
                    }
                    .buttonStyle(.glassProminent)
                    .tint(.orange)
                }
            }
            .sheet(isPresented: $showAddBookView) {
                AddBookView()
            }
        }
    }
}

#Preview {
    BookListView()
}
