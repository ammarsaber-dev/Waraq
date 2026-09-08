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
        .sheet(isPresented: $showSession) {
            ReadingSessionView(book: book, modelContext: modelContext)
                .presentationDetents([.fraction(0.75), .large])
        }
        .sheet(isPresented: $showTodayGoal) {
            AddDailyGoalView(book: book)
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
