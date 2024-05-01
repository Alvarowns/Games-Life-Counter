//
//  ChangeColorPalette.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 27/4/24.
//

import SwiftUI

struct ChangeColorPalette: View {
    @Binding var popOver: Bool
    @Binding var playerColor: Color
    
    var vertical: Bool
    
    var body: some View {
        VStack {
            Image(.blueMana)
                .manaSymbols(vertical: vertical)
                .onTapGesture {
                    playerColor = .isleColor1
                    popOver = false
                }
            
            HStack {
                Image(.greenMana)
                    .manaSymbols(vertical: vertical)
                    .onTapGesture {
                        playerColor = .forestColor1
                        popOver = false
                    }
                Image(.redMana)
                    .manaSymbols(vertical: vertical)
                    .onTapGesture {
                        playerColor = .mountainColor1
                        popOver = false
                    }
                Image(.whiteMana)
                    .manaSymbols(vertical: vertical)
                    .onTapGesture {
                        playerColor = .plainsColor1
                        popOver = false
                    }
            }
            
            Image(.blackMana)
                .manaSymbols(vertical: vertical)
                .onTapGesture {
                    playerColor = .swampColor1
                    popOver = false
                }
        }
        .font(vertical ? .largeTitle : .headline)
        .padding()
        .background {
            Circle()
                .shadow(radius: 5)
            Color.black
                .clipShape(Circle())
        }
    }
}

#Preview {
    ChangeColorPalette(popOver: .constant(false), playerColor: .constant(.isleColor1), vertical: true)
}
