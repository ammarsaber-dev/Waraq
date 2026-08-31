//
//  AddBookView.swift
//  Waraq
//
//  Created by Ammar Saber on 29/08/2026.
//

import SwiftUI
import SwiftData

struct AddBookView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var currentPage: Int?
    @State private var totalPage: Int?
    @State private var hasStartedReading = false
    
    var isValidForm: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && totalPage ?? 0 > 0
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Book Title", text: $title)
                TextField("Book Author", text: $author)
                
                TextField("Total pages of the book", value: $totalPage, format: .number)
                    .keyboardType(.numberPad)
                
                Section {
                    Toggle("I've already started reading", isOn: $hasStartedReading)
                    
                    if hasStartedReading {
                        TextField("Current page", value: $currentPage, format: .number)
                            .keyboardType(.numberPad)
                    }
                }
            }
            .navigationTitle("New Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", role: .confirm) {
                        let book = Book(
                            title: title,
                            author: author,
                            totalPages: totalPage ?? 0,
                            currentPage: hasStartedReading ? (currentPage ?? 0) : 0
                        )
                        
                        modelContext.insert(book)
                        dismiss()
                    }
                    .disabled(!isValidForm)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddBookView()
        .modelContainer(for: Book.self, inMemory: true)
}
