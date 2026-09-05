//
//  WaraqApp.swift
//  Waraq
//
//  Created by Ammar Saber on 29/08/2026.
//

import SwiftUI
import SwiftData

@main
struct WaraqApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Book.self, ReadingSession.self, DailyGoal.self])
    }
}
