//
//  MoreColorsView.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 8/5/24.
//

import SwiftUI

struct MoreColorsView: View {
    let color: Color
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: width, height: height)
            .foregroundStyle(color.opacity(0.9))
            .shadow(radius: 2)
    }
}

#Preview {
    MoreColorsView(color: .banana, width: 100, height: 100)
}
