//
//  TodaysGoalView.swift
//  Waraq
//
//  Created by Ammar Saber on 07/09/2026.
//

import SwiftUI

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
