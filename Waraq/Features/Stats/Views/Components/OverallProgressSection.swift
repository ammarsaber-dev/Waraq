//
//  OverallProgressSection.swift
//  Waraq
//
//  Created by Ammar Saber on 07/09/2026.
//

import SwiftUI

struct OverallProgressSection: View {
    let totalPagesRead: Int
    let totalTimeReading: TimeInterval
    let finishedCount: Int
    let readingCount: Int

    private var formattedTime: String {
        Duration.seconds(totalTimeReading)
            .formatted(
                .units(allowed: [.hours, .minutes], width: .abbreviated)
            )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Overall progress")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 10
            ) {
                MetricCardView(label: "Pages read", value: "\(totalPagesRead)")
                MetricCardView(label: "Time reading", value: formattedTime)
            }

            BooksSummaryCardView(
                finishedCount: finishedCount,
                readingCount: readingCount
            )
        }
    }
}
