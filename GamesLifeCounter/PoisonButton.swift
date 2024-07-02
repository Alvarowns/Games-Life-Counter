//
//  poisonButton.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 27/4/24.
//

import SwiftUI

struct PoisonButton: View {
    @Binding var poison: Bool
    
    var padding: CGFloat
    
    var body: some View {
        Image(.poisonCounter)
            .resizable()
            .scaledToFill()
            .frame(width: 20, height: 20)
            .padding(padding)
            .onTapGesture {
                poison.toggle()
            }
            .background {
                poison ? Circle().foregroundStyle(.black.opacity(0.3)).shadow(radius: 1) : nil
            }
            .padding()
    }
}

#Preview {
    PoisonButton(poison: .constant(true), padding: 15)
}
