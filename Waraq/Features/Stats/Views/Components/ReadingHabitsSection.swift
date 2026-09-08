//
//  ReadingHabitsSection.swift
//  Waraq
//
//  Created by Ammar Saber on 07/09/2026.
//

import SwiftUI

struct ReadingHabitsSection: View {
    let streak: Int
    let averageSessionLength: TimeInterval
    let mostReadBook: Book?
    let sessionCount: Int

    private var formattedAverage: String {
        Duration.seconds(averageSessionLength)
            .formatted(.units(allowed: [.minutes], width: .abbreviated))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Reading habits")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            VStack(spacing: 8) {
                HabitRowView(
                    icon: "flame",
                    iconColor: .orange,
                    label: "Reading streak",
                    value: "\(streak) day\(streak == 1 ? "" : "s")"
                )
                HabitRowView(
                    icon: "clock",
                    iconColor: .secondary,
                    label: "Avg. session",
                    value: formattedAverage
                )

                if let mostReadBook {
                    HabitRowView(
                        icon: "book",
                        iconColor: .secondary,
                        label: "Most read",
                        value: mostReadBook.title
                    )
                }

                HabitRowView(
                    icon: "list.number",
                    iconColor: .secondary,
                    label: "Sessions logged",
                    value: "\(sessionCount)"
                )
            }
        }
    }
}
