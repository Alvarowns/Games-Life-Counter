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
            .frame(width: vertical ? 48 : 45, height: vertical ? 48 : 45)
    }
}
