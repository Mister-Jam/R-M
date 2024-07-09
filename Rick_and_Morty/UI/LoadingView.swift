//
//  LoadingView.swift
//  Rick_and_Morty
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var rotation: Double = 0
    
    var body: some View {

            ZStack {
                Color.clear.ignoresSafeArea()
                Circle()
                    .fill(color)
                    .frame(width: circleSize, height: circleSize)
                ForEach(0..<count, id: \.self) { i in
                    
                    Circle()
                        .trim(from: .zero, to: 0.1 + CGFloat(i / count))
                        .stroke(color, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .frame(width: circleSize + 20 + CGFloat(i * 30), height: circleSize + 20 + CGFloat(i * 30))
                        .rotationEffect(.degrees(rotation))
                    
                        .animation(Animation
                            .linear(duration: 3.0 / Double(count - i))
                            .repeatForever(autoreverses: false)
                            .speed(1.3), value: rotation)
                    
                }
            }
            .onAppear() {
                rotation = -360
            }
            .background(Color.blue.opacity(0.3))
        
        
        
    }
    
    // MARK: - Drawing constants
    let circleSize: CGFloat = 30
    let count: Int = 6
    let color = RadialGradient(
        gradient: Gradient(colors: [.green, .blue]),
        center: .center,
        startRadius: .zero,
        endRadius: .zero)
}


#Preview {
    LoadingView()
}
