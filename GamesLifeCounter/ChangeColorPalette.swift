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
            HStack {
                Image(.blueMana)
                    .manaSymbols(vertical: vertical)
                    .onTapGesture {
                        playerColor = .isleColor1
                        popOver = false
                    }
                
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
                
                Image(.blackMana)
                    .manaSymbols(vertical: vertical)
                    .onTapGesture {
                        playerColor = .swamp
                        popOver = false
                    }
                
            }
            HStack {
                MoreColorsView(color: .honeydew, width: 28, height: 28)
                    .onTapGesture {
                        playerColor = .honeydew.opacity(0.9)
                        popOver = false
                    }
                MoreColorsView(color: .banana, width: 28, height: 28)
                    .onTapGesture {
                        playerColor = .banana.opacity(0.9)
                        popOver = false
                    }
                MoreColorsView(color: .spindrift, width: 28, height: 28)
                    .onTapGesture {
                        playerColor = .spindrift.opacity(0.9)
                        popOver = false
                    }
                MoreColorsView(color: .sky, width: 28, height: 28)
                    .onTapGesture {
                        playerColor = .sky.opacity(0.9)
                        popOver = false
                    }
                MoreColorsView(color: .flora, width: 28, height: 28)
                    .onTapGesture {
                        playerColor = .flora.opacity(0.9)
                        popOver = false
                    }
            }
            
            HStack {
                MoreColorsView(color: .orchid, width: 28, height: 28)
                    .onTapGesture {
                        playerColor = .orchid.opacity(0.9)
                        popOver = false
                    }
                MoreColorsView(color: .salmon, width: 28, height: 28)
                    .onTapGesture {
                        playerColor = .salmon.opacity(0.9)
                        popOver = false
                    }
                MoreColorsView(color: .bubblegum, width: 28, height: 28)
                    .onTapGesture {
                        playerColor = .bubblegum.opacity(0.9)
                        popOver = false
                    }
                MoreColorsView(color: .metal, width: 28, height: 28)
                    .onTapGesture {
                        playerColor = .metal.opacity(0.9)
                        popOver = false
                    }
            }
        }
    }
}

#Preview {
    ChangeColorPalette(popOver: .constant(false), playerColor: .constant(.isleColor1), vertical: true)
}
