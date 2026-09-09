//
//  SettingsView.swift
//  Waraq
//
//  Created by Ammar Saber on 09/09/2026.
//

import SwiftUI

struct SettingsView: View {
    @State private var reminderEnabled = false
    @State private var reminderTime = Date()

    var body: some View {
        NavigationStack {
            Form {
                Section("Reminders") {
                    Toggle("Daily Reading Reminder", isOn: $reminderEnabled)

                    if reminderEnabled {
                        DatePicker(
                            "Reminder Time",
                            selection: $reminderTime,
                            displayedComponents: .hourAndMinute
                        )
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
