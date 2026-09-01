//
//  ContentView.swift
//  Waraq
//
//  Created by Ammar Saber on 29/08/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Books", systemImage: "books.vertical") {
                BookListView()
            }
            
            Tab("Stats", systemImage: "chart.bar.fill") {
                StatsView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Book.self, ReadingSession.self], inMemory: true)
}
