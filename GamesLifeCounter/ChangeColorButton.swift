//
//  ChangeColorView.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 27/4/24.
//

import SwiftUI

struct ChangeColorButton: View {
    @Binding var popOver: Bool
    
    var font: Font
    
    var body: some View {
        Button {
            popOver.toggle()
        } label: {
            Image(systemName: "circle.hexagonpath")
                .font(font)
        }
        .fontWeight(.semibold)
        .font(.title)
    }
}

#Preview {
    ChangeColorButton(popOver: .constant(false), font: .title3)
        .background(.black)
}
