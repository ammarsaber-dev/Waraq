//
//  BookProgressUpdateView.swift
//  Waraq
//
//  Created by Ammar Saber on 07/09/2026.
//

import SwiftUI

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
