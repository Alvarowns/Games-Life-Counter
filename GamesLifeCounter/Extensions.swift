//
//  Extensions.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 27/4/24.
//

import SwiftUI

extension Image {
    func manaSymbols(vertical: Bool) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: vertical ? 45 : 35, height: vertical ? 45 : 35)
            .shadowPop()
    }
}

extension View {
    func shadowPop() -> some View {
        self
            .shadow(radius: 0.4)
            .shadow(radius: 0.4)
            .shadow(radius: 0.4)
            .shadow(radius: 0.4)
    }
}
