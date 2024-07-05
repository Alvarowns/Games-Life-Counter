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
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var sizeClassFont: Font {
        if horizontalSizeClass == .compact {
            return .largeTitle
        } else if horizontalSizeClass == .regular {
            return .custom("", size: 100)
        }
        return .largeTitle
    }
    
    var body: some View {
        VStack {
            HStack {
                ChangeColorButton(popOver: $popOver, font: horizontalSizeClass == .compact ? .title : .custom("ipad", size: 60))
                
                Spacer()
                
                Button {
                    someoneWon.toggle()
                    winnerName = playerName
                } label: {
                    Image(systemName: "crown")
                }
                .font(horizontalSizeClass == .compact ? .title : .custom("ipad", size: 60))
                .blur(radius: popOver ? 2.0 : 0.0)
                .disabled(popOver ? true : false)
            }
            .padding(.horizontal)
            .padding(.top)
            .fontWeight(.semibold)
            
            
            ZStack {
                VStack(spacing: 30) {
                    Button {
                        changeName.toggle()
                    } label: {
                        Text(playerName)
                            .font(horizontalSizeClass == .compact ? .title : .custom("ipad", size: 80))
                            .multilineTextAlignment(.center)
                            .fontWeight(.medium)
                    }
                    
                    HStack(spacing: 50) {
                        Button {
                            playerLife -= 1
                        } label: {
                            Image(systemName: "minus.circle")
                                .font(sizeClassFont)
                        }
                        .buttonRepeatBehavior(.enabled)
                        
                        Text("\(playerLife)")
                            .font(horizontalSizeClass == .compact ? .custom("iphone", size: 120) : .custom("ipad", size: 180))
                        
                        Button {
                            playerLife += 1
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(sizeClassFont)
                        }
                        .buttonRepeatBehavior(.enabled)
                    }
                    .disabled(popOver ? true : false)
                }
                .blur(radius: popOver ? 2.0 : 0.0)
                
                
                ChangeColorPalette(popOver: $popOver, playerColor: $playerColor, vertical: true)
                    .opacity(popOver ? 1.0 : 0.0)
                    .padding(.bottom)
                    .padding(.bottom)
                
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
