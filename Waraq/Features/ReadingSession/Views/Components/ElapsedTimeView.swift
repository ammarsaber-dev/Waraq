//
//  ElapsedTimeView.swift
//  Waraq
//
//  Created by Ammar Saber on 07/09/2026.
//

import SwiftUI

struct ElapsedTimeView: View {
    let viewModel: ReadingSessionViewModel

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1.0)) { _ in
            Text(Duration.seconds(viewModel.duration).formatted(.time(pattern: .minuteSecond)))
                .font(.system(size: 56))
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .monospacedDigit()
                .contentTransition(.numericText())
                .animation(.snappy, value: viewModel.duration)
        }
    }
}
