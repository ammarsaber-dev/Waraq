//
//  BookDetailView.swift
//  Waraq
//
//  Created by Ammar Saber on 30/08/2026.
//

import SwiftUI
import SwiftData

struct BookDetailView: View {
    @Bindable var book: Book
    
    @Environment(\.modelContext) private var modelContext
    @State private var showSession = false

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                BookHeaderView(book: book)
                BookProgressSummaryView(book: book)
                BookProgressUpdateView(book: book)
                
                Button("Start Reading Session") {
                    showSession = true
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle("Book Details")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showSession) {
            ReadingSessionView(book: book, modelContext: modelContext)
        }
    }
}

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

struct BookProgressUpdateView: View {
    @Bindable var book: Book
    @State private var showManualEntry = false
    @State private var manualPageText = ""

    private let increments = [10, 25, 50]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Update progress")
                .font(.headline)

            HStack(spacing: 10) {
                ForEach(increments, id: \.self) { amount in
                    Button("+\(amount)") {
                        book.currentPage = min(book.currentPage + amount, book.totalPages)
                    }
                    .buttonStyle(.bordered)
                }

                Spacer()

                Button {
                    manualPageText = "\(book.currentPage)"
                    showManualEntry = true
                } label: {
                    Image(systemName: "pencil")
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
        .alert("Set current page", isPresented: $showManualEntry) {
            TextField("Page", text: $manualPageText)
                .keyboardType(.numberPad)
            Button("Cancel", role: .cancel) { }
            Button("Save") {
                if let page = Int(manualPageText) {
                    book.currentPage = min(max(page, 0), book.totalPages)
                }
            }
        }
    }
}

#Preview {
    BookDetailView(
        book: .init(
            title: "Nothing but me",
            author: "Ammar Saber",
            totalPages: 936
        )
    )
}
