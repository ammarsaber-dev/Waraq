//
//  HabitRowView.swift
//  Waraq
//
//  Created by Ammar Saber on 07/09/2026.
//

import SwiftUI

struct HabitRowView: View {
    let icon: String
    let iconColor: Color
    let label: String
    let value: String

    var body: some View {
        HStack {
            Label {
                Text(label)
            } icon: {
                Image(systemName: icon)
                    .foregroundStyle(iconColor)
            }
            .font(.subheadline)

            Spacer()

            Text(value)
                .font(.subheadline.weight(.medium))
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
    }
}
