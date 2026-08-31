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

            ElapsedTimeView(elapsed: viewModel.elapsed)

            SessionControlsView(
                state: viewModel.state,
                onStart: { viewModel.start() },
                onCancel: {
                    viewModel.cancel()
                    dismiss()
                },
                onEndTapped: {
                    viewModel.pauseForEnding()
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
                viewModel.resumeAfterCancelingEnd()
            }
            Button("Save") {
                guard let page = Int(endPageText) else { return }
                viewModel.end(atPage: page)
                dismiss()
            }
            .disabled(!isEndPageValid)
        }
    }
}

struct ElapsedTimeView: View {
    let elapsed: TimeInterval

    private var formatted: String {
        Duration.seconds(elapsed)
            .formatted(.time(pattern: .minuteSecond))
    }

    var body: some View {
        Text(formatted)
            .font(.system(size: 56))
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .monospacedDigit()
            .contentTransition(.numericText())
            .animation(.snappy, value: elapsed)
    }
}

struct SessionControlsView: View {
    let state: ReadingSessionViewModel.State
    let onStart: () -> Void
    let onCancel: () -> Void
    let onEndTapped: () -> Void

    var body: some View {
        switch state {
        case .idle:
            Button("Start", action: onStart)
                .buttonStyle(.borderedProminent)

        case .running:
            HStack(spacing: 16) {
                Button("Cancel", role: .destructive, action: onCancel)
                Button("End Session", action: onEndTapped)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}
