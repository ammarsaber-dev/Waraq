//
//  MetricCardView.swift
//  Waraq
//
//  Created by Ammar Saber on 07/09/2026.
//

import SwiftUI

struct MetricCardView: View {
    let label: LocalizedStringKey
    let value: Text

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            value
                .font(.title3.weight(.medium))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
    }
}
