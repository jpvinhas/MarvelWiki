//
//  ShimmerEffectBox.swift
//  MarvelWiki
//
//  Created by Ricardo Silva Vale on 17/07/24.
//

import SwiftUI
struct ShimmerEffectBox: View {
    @State private var isAnimating  = false
    private var gradientColors = [
        Color(.tabBlue),
        Color(red: 105 / 255, green: 105 / 255, blue: 143 / 255, opacity: 255),
        Color(.tabBlue)
    ]
    
    @State var startPoint: UnitPoint = .init(x: -2.0, y: -1.5)
    @State var endPoint: UnitPoint = .init(x: 0, y: -0.2)
    
    var body: some View {
        LinearGradient(colors: gradientColors, startPoint: startPoint, endPoint: endPoint )
         .onAppear{
                withAnimation(.easeInOut(duration: 1)
                    .repeatForever(autoreverses: false)){
                        startPoint = .init(x: 1, y: 1)
                        endPoint = .init(x: 2.2, y: 2.2)
                        
                    }
            }
    }
}

#Preview {
    ShimmerEffectBox()
}
