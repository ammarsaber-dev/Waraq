//
//  CircularProgressView.swift
//  Waraq
//
//  Created by Ammar Saber on 29/08/2026.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    let strokeWidth: CGFloat
    let color: Color
    let showPercentage: Bool
    let percentageFont: Font
    
    init(progress: Double,
         strokeWidth: CGFloat,
         color: Color,
         showPercentage: Bool = true,
         percentageFont: Font = .caption
    ) {
        self.progress = progress
        self.strokeWidth = strokeWidth
        self.color = color
        self.showPercentage = showPercentage
        self.percentageFont = percentageFont
    }
    
    var formattedProgress: String {
        let progressInPercentage = progress * 100
        return "\(Int(progressInPercentage))%"
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: strokeWidth)
                .opacity(0.1)
                .foregroundStyle(color)
            
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round))
                .foregroundStyle(color)
                .rotationEffect(.degrees(270))
                .animation(.smooth.speed(0.5), value: progress)
            
            if showPercentage {
                Text(formattedProgress)
                    .font(percentageFont)
            }
        }
    }
}

#Preview {
    CircularProgressView(progress: 0.82, strokeWidth: 5, color: .red)
}
