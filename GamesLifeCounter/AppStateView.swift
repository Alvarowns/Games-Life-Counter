//
//  AppStateView.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 1/7/24.
//

import SwiftUI

struct AppStateView: View {
    @State private var start: Bool = false
    @State private var size: Double = 0.8
    @State private var opacity: Double = 0.5
    
    var body: some View {
        if !start {
            VStack {
                Image(.gamesLifeCounterLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 150)
                    .background(.white)
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.5)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.start = true
                }
            }
        } else {
            ContentView()
                .animation(.easeIn, value: start)
        }
    }
}
