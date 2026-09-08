//
//  AddDailyGoalView.swift
//  Waraq
//
//  Created by Ammar Saber on 03/09/2026.
//

import SwiftUI
import SwiftData

struct AddDailyGoalView: View {
    let book: Book

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var targetPages: Int?

    private let quickTargets = [10, 20, 30]

    var isValid: Bool {
        guard let targetPages else { return false }
        return targetPages > 0
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text(book.title)
                            .font(.headline)
                        Spacer()
                        Text("\(book.currentPage)/\(book.totalPages) pages")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Pages to read today") {
                    TextField("e.g. 20", value: $targetPages, format: .number)
                            .keyboardType(.numberPad)
                    
                    HStack(spacing: 10) {
                        ForEach(quickTargets, id: \.self) { amount in
                            Button("\(amount)") { targetPages = amount }
                                .buttonStyle(.bordered)
                        }
                        Button("+5") {
                            targetPages = (targetPages ?? 0) + 5
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            .navigationTitle("Today's Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        let goal = DailyGoal(targetBook: book, targetPages: targetPages ?? 0)
                        modelContext.insert(goal)
                        
                        dismiss()
                    }
                    .buttonStyle(.glassProminent)
                    .disabled(!isValid)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddDailyGoalView(book: .init(title: "Everything but the code", author: "Paul Hudson", totalPages: 472))
}
