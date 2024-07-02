//
//  SinglePlayerView.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 27/4/24.
//

import SwiftUI

struct SinglePlayerView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @Binding var playerName: String
    @Binding var playerLife: Int
    @Binding var playerPoisonCounters: Int
    @Binding var playerColor: Color
    @Binding var changeName: Bool
    @Binding var someoneWon: Bool
    @Binding var winnerName: String
    
    @State private var popOver: Bool = false
    @State private var poison: Bool = false
    
    var fontSize: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                ChangeColorButton(popOver: $popOver, font: horizontalSizeClass == .compact ? .title : .custom("iPad", size: 40))
                
                Spacer()
                
                Button {
                    
                        someoneWon.toggle()
                        winnerName = playerName
                } label: {
                    Image(systemName: "crown")
                }
                .font(horizontalSizeClass == .compact ? .title : .custom("iPad", size: 40))
                .blur(radius: popOver ? 2.0 : 0.0)
                .disabled(popOver ? true : false)
            }
            .font(.title)
            .padding(.horizontal)
            .padding(.top)
            .fontWeight(.semibold)
            
            Spacer()
            
            ZStack {
                VStack {
                    Text(playerName)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                        .onTapGesture {
                            changeName.toggle()
                        }
                    
                    HStack(spacing: 50) {
                        Button {
                            playerLife -= 1
                        } label: {
                            Image(systemName: "minus.circle")
                                .font(horizontalSizeClass == .compact ? .largeTitle : .custom("iPad", size: 100))
                        }
                        .buttonRepeatBehavior(.enabled)
                        
                        Text("\(playerLife)")
                            .font(horizontalSizeClass == .compact ? .custom("iPhone", size: fontSize) : .custom("iPad", size: 240))
                            .lineLimit(1)
                        
                        Button {
                            playerLife += 1
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(horizontalSizeClass == .compact ? .largeTitle : .custom("iPad", size: 100))
                        }
                        .buttonRepeatBehavior(.enabled)
                    }
                    .disabled(popOver ? true : false)
                    
                    HStack(spacing: 50) {
                        Button {
                            playerPoisonCounters -= 1
                        } label: {
                            Image(systemName: "minus.circle")
                                .font(.title)
                        }
                        .buttonRepeatBehavior(.enabled)
                        
                        Text("\(playerPoisonCounters)")
                            .font(.largeTitle)
                            .lineLimit(1)
                        
                        Button {
                            playerPoisonCounters += 1
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.title)
                        }
                        .buttonRepeatBehavior(.enabled)
                    }
                    .foregroundStyle(.black)
                    .shadow(color: .black, radius: 0.6, x: 0, y: 1)
                    .opacity(poison ? 1.0 : 0.0)
                }
                .blur(radius: popOver ? 2.0 : 0.0)
                
                if popOver {
                    ChangeColorPalette(popOver: $popOver, playerColor: $playerColor, vertical: true)
                        .padding(.bottom)
                        .padding(.bottom)
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                PoisonButton(poison: $poison, padding: 15)
                    .blur(radius: popOver ? 2.0 : 0.0)
            }
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

#Preview {
    SinglePlayerView(playerName: .constant("Player 1"), playerLife: .constant(20), playerPoisonCounters: .constant(0), playerColor: .constant(.isleColor1), changeName: .constant(false), someoneWon: .constant(false), winnerName: .constant(""), fontSize: 150)
        .environmentObject(MainViewVM())
}
