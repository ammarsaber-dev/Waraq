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

    @Query private var dailyGoals: [DailyGoal]
    @Environment(\.modelContext) private var modelContext

    @State private var showSession = false
    @State private var showTodayGoal = false

    var bookIsFinished: Bool {
        book.status == .finished
    }

    var todaysGoal: DailyGoal? {
        dailyGoals.today(for: book)
    }

    var goalAlreadyExists: Bool {
        todaysGoal != nil
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                BookHeaderView(book: book)
                BookProgressSummaryView(book: book)

                if let todaysGoal {
                    TodaysGoalView(goal: todaysGoal)
                } else if !bookIsFinished {
                    Button {
                        showTodayGoal = true
                    } label: {
                        Label("Set Today's Goal", systemImage: "target")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }

                Button {
                    showSession = true
                } label: {
                    Label("Start Reading Session", systemImage: "play.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(bookIsFinished)

                Divider()

                BookProgressUpdateView(book: book)
            }
            .padding()
        }
        .navigationTitle("Book Details")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showSession) {
            ReadingSessionView(book: book, modelContext: modelContext)
        }
        .sheet(isPresented: $showTodayGoal) {
            AddDailyGoalView(book: book)
        }
    }
}

struct TodaySectionView: View {
    let goal: DailyGoal?
    let sessions: [ReadingSession]
    let bookIsFinished: Bool
    let onStartSession: () -> Void
    let onSetGoal: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today")
                .font(.headline)
                .foregroundStyle(.secondary)

            if let goal {
                TodaysGoalView(goal: goal)
            }

            VStack(spacing: 10) {
                Button {
                    onStartSession()
                } label: {
                    Label("Start Reading Session", systemImage: "timer")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(bookIsFinished)

                if goal == nil {
                    Button {
                        onSetGoal()
                    } label: {
                        Label("Set Today's Goal", systemImage: "target")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .disabled(bookIsFinished)
                }
            }
        }
    }
}

struct TodaysGoalView: View {
    let goal: DailyGoal

    private var progress: Double {
        min(Double(goal.pagesRead) / Double(goal.targetPages), 1.0)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("Today's Goal", systemImage: "target")
                    .font(.headline)
                Spacer()
                if goal.isAchieved {
                    Label("Achieved", systemImage: "checkmark.seal.fill")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.green)
                }
            }

            ProgressView(value: progress)
                .tint(goal.isAchieved ? .green : .blue)
                .animation(.smooth.speed(0.3), value: progress)

            Text("\(goal.pagesRead) / \(goal.targetPages) pages read today")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
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
