//
//  SessionControlsView.swift
//  Waraq
//
//  Created by Ammar Saber on 07/09/2026.
//

import SwiftUI

struct SessionControlsView: View {
    let sessionIsRunning: Bool
    let onStart: () -> Void
    let onCancel: () -> Void
    let onEndTapped: () -> Void

    var body: some View {
        if !sessionIsRunning {
            Button("Start", action: onStart)
                .buttonStyle(.borderedProminent)
        } else {
            HStack(spacing: 16) {
                Button("Cancel", role: .destructive, action: onCancel)
                Button("End Session", action: onEndTapped)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}
