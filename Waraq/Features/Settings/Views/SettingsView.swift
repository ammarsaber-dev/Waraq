//
//  SettingsView.swift
//  Waraq
//
//  Created by Ammar Saber on 09/09/2026.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("reminderEnabled") private var reminderEnabled = false
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
            .onAppear {
                loadReminderTime()
            }
            .onChange(of: reminderTime) { _, _ in
                storeReminderTime()
            }
        }
    }
    
    func storeReminderTime() {
        let components = Calendar.current.dateComponents(
            [.hour, .minute],
            from: reminderTime
        )
        UserDefaults.standard.set(components.hour, forKey: "reminderHour")
        UserDefaults.standard.set(components.minute, forKey: "reminderMinute")
    }

    func loadReminderTime() {
        if let hour = UserDefaults.standard.object(forKey: "reminderHour")
            as? Int,
            let minute = UserDefaults.standard.object(forKey: "reminderMinute")
                as? Int
        {

            reminderTime =
                Calendar.current.date(
                    bySettingHour: hour,
                    minute: minute,
                    second: 0,
                    of: Date()
                ) ?? Date()
        } else {
            reminderTime =
                Calendar.current.date(
                    bySettingHour: 20,
                    minute: 0,
                    second: 0,
                    of: Date()
                ) ?? Date()
        }
    }
}

#Preview {
    SettingsView()
}
