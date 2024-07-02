//
//  SinglePlayerView.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 27/4/24.
//

import SwiftUI

struct SinglePlayerView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @Binding var playerName: String
    @Binding var playerLife: Int
    @Binding var playerPoisonCounters: Int
    @Binding var playerColor: Color
    @Binding var changeName: Bool
    @Binding var someoneWon: Bool
    @Binding var winnerName: String
    
    @State private var popOver: Bool = false
    @State private var poison: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                ChangeColorButton(popOver: $popOver, font: .title)
                
                Spacer()
                
                Button {
                    someoneWon.toggle()
                    winnerName = playerName
                } label: {
                    Image(systemName: "crown")
                }
                .font(.title)
                .blur(radius: popOver ? 2.0 : 0.0)
                .disabled(popOver ? true : false)
            }
            .font(.title)
            .padding(.horizontal)
            .padding(.top)
            .fontWeight(.semibold)
            
            
            ZStack {
                VStack(spacing: 30) {
                    Button {
                        changeName.toggle()
                    } label: {
                        Text(playerName)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .fontWeight(.medium)
                    }
                    
                    HStack(spacing: 50) {
                        Button {
                            playerLife -= 1
                        } label: {
                            Image(systemName: "minus.circle")
                                .font(.largeTitle)
                        }
                        .buttonRepeatBehavior(.enabled)
                        
                        Text("\(playerLife)")
                            .font(.custom("", size: 120))
                        
                        Button {
                            playerLife += 1
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.largeTitle)
                        }
                        .buttonRepeatBehavior(.enabled)
                    }
                    .disabled(popOver ? true : false)
                }
                .blur(radius: popOver ? 2.0 : 0.0)
                
                if popOver {
                    ChangeColorPalette(popOver: $popOver, playerColor: $playerColor, vertical: true)
                        .padding(.bottom)
                        .padding(.bottom)
                }
            }
            
            Spacer()
        }
        .shadow(radius: 1)
        .foregroundStyle(.white)
        .bold()
        .frame(maxWidth: .infinity)
        .background {
                playerColor
                    .onTapGesture {
                        viewModel.changeLife = false
                        viewModel.changePlayersNumbers = false
                        popOver = false
                    }
        }
    }
}
