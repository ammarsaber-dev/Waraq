//
//  ReadingSessionView.swift
//  Waraq
//
//  Created by Ammar Saber on 31/08/2026.
//

import SwiftUI
import SwiftData

struct ReadingSessionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: ReadingSessionViewModel
    @State private var showEndPrompt = false
    @State private var endPageText = ""

    init(book: Book, modelContext: ModelContext) {
        _viewModel = State(initialValue: ReadingSessionViewModel(book: book, modelContext: modelContext))
    }

    private var isEndPageValid: Bool {
        guard let page = Int(endPageText) else { return false }
        return page >= viewModel.book.currentPage && page <= viewModel.book.totalPages
    }

    var body: some View {
        VStack(spacing: 32) {
            Text(viewModel.book.title)
                .font(.title2)
                .fontWeight(.bold)
                .fontWidth(.expanded)
                .multilineTextAlignment(.center)

            ElapsedTimeView(viewModel: viewModel)

            SessionControlsView(
                sessionIsRunning: viewModel.startDate != nil,
                onStart: { viewModel.start() },
                onCancel: {
                    viewModel.cancel()
                    dismiss()
                },
                onEndTapped: {
                    viewModel.pause()
                    endPageText = "\(viewModel.book.currentPage)"
                    showEndPrompt = true
                }
            )
        }
        .padding()
        .alert("What page did you stop at?", isPresented: $showEndPrompt) {
            TextField("Page", text: $endPageText)
                .keyboardType(.numberPad)
            Button("Cancel", role: .cancel) {
                viewModel.resume()
            }
            Button("Save") {
                guard let page = Int(endPageText) else { return }
                viewModel.end(atPage: page)
                dismiss()
            }
            .disabled(!isEndPageValid)
        }
        .onDisappear {
            if viewModel.startDate != nil {
                viewModel.cancel()
            }
        }
    }
}
