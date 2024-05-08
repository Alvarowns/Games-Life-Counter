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
            .frame(width: vertical ? 45 : 32, height: vertical ? 45 : 32)
            .shadow(radius: 2)
    }
}
