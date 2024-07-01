//
//  SinglePlayerView.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 27/4/24.
//

import SwiftUI

struct SinglePlayerViewHorizontal: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @Binding var playerLife: Int
    @Binding var playerPoisonCounters: Int
    @Binding var playerColor: Color
    @Binding var playerName: String
    @Binding var changeName: Bool
    @Binding var someoneWon: Bool
    @Binding var winnerName: String
    
    @State private var popOver: Bool = false
    @State private var poison: Bool = false
    
    var fontSize: CGFloat
    var isLeftSide: Bool
    var isHalfDown: Bool
    var sizeClassFont: Font {
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            // iPhone
            return .title2
        } else if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            // iPad
            return .largeTitle
        } else {
            return .title2
        }
    }
    
    var body: some View {
        VStack {
            if isLeftSide {
                if !isHalfDown {
                    HStack {
                        Spacer()
                        
                        ChangeColorButton(popOver: $popOver, font: horizontalSizeClass == .compact ? .title : .custom("iPad", size: 30))
                    }
                    .font(sizeClassFont)
                    .padding(.horizontal)
                    .padding(.top)
                    .fontWeight(.semibold)
                } else {
                    HStack {
                        PoisonButton(poison: $poison, padding: 8)
                            .rotationEffect(.degrees(90))
                            .scaleEffect(CGSize(width: 1.0, height: 1.0))
                        
                        Spacer()
                        
                        Button {
                            someoneWon.toggle()
                            winnerName = playerName
                        } label: {
                            Image(systemName: "crown")
                        }
                        .rotationEffect(.degrees(90))
                        .font(sizeClassFont)
                        .padding()
                        .blur(radius: popOver ? 2.0 : 0.0)
                        .disabled(popOver ? true : false)
                    }
                }
            } else {
                if !isHalfDown {
                    HStack {
                        PoisonButton(poison: $poison, padding: 8)
                            .rotationEffect(.degrees(90))
                            .scaleEffect(CGSize(width: 1.0, height: 1.0))
                            .blur(radius: popOver ? 2.0 : 0.0)
                        
                        Spacer()
                        
                        Button {
                            someoneWon.toggle()
                            winnerName = playerName
                        } label: {
                            Image(systemName: "crown")
                        }
                        .rotationEffect(.degrees(90))
                        .font(sizeClassFont)
                        .padding()
                        .blur(radius: popOver ? 2.0 : 0.0)
                        .disabled(popOver ? true : false)
                    }
                } else {
                    
                    HStack {
                        Spacer()
                        ChangeColorButton(popOver: $popOver, font: horizontalSizeClass == .compact ? .title : .custom("iPad", size: 30))
                    }
                    .font(sizeClassFont)
                    .padding(.horizontal)
                    .padding(.top)
                    .fontWeight(.semibold)
                }
            }
            
            Spacer()
            
            ZStack {
                HStack {
                    if poison {
                        VStack(spacing: 50) {
                            Button {
                                playerPoisonCounters -= 1
                            } label: {
                                Image(systemName: "minus.circle")
                                    .rotationEffect(.degrees(90))
                                    .font(.title)
                            }
                            .buttonRepeatBehavior(.enabled)
                            
                            Text("\(playerPoisonCounters)")
                                .font(.largeTitle)
                                .lineLimit(1)
                                .rotationEffect(.degrees(90))
                            
                            Button {
                                playerPoisonCounters += 1
                            } label: {
                                Image(systemName: "plus.circle")
                                    .font(.title)
                            }
                            .buttonRepeatBehavior(.enabled)
                        }
                        .foregroundStyle(.black.opacity(0.3))
                        .shadow(color: .black, radius: 1, x: 0, y: 1)
                    }
                    
                    HStack {
                        VStack(spacing: 50) {
                            Button {
                                playerLife -= 1
                            } label: {
                                Image(systemName: "minus.circle")
                                    .font(horizontalSizeClass == .compact ? .largeTitle : .custom("iPad", size: 50))
                                    .rotationEffect(.degrees(90))
                            }
                            .buttonRepeatBehavior(.enabled)
                            
                            Text("\(playerLife)")
                                .font(horizontalSizeClass == .compact ? .custom("iPhone", size: fontSize) : .custom("iPad", size: 100))
                                .rotationEffect(.degrees(90))
                                .padding(.vertical, 2)
                            
                            Button {
                                playerLife += 1
                            } label: {
                                Image(systemName: "plus.circle")
                                    .font(horizontalSizeClass == .compact ? .largeTitle : .custom("iPad", size: 50))
                            }
                            .buttonRepeatBehavior(.enabled)
                        }
                        
                        Text(playerName)
                            .multilineTextAlignment(.center)
                            .rotationEffect(.degrees(90))
                            .frame(width: 80,height: 250)
                            .lineLimit(1)
                            .font(.title3)
                            .onTapGesture {
                                changeName.toggle()
                            }
                        
                    }
                    .disabled(popOver ? true : false)
                }
                .blur(radius: popOver ? 2.0 : 0.0)
                
                if popOver {
                    ChangeColorPalette(popOver: $popOver, playerColor: $playerColor, vertical: false)
                        .rotationEffect(.degrees(90))
                }
            }
            
            Spacer()
            
            if isLeftSide {
                if !isHalfDown {
                    HStack {
                        PoisonButton(poison: $poison, padding: 8)
                            .rotationEffect(.degrees(90))
                            .scaleEffect(CGSize(width: 1.0, height: 1.0))
                        
                        Spacer()
                        
                        Button {
                            someoneWon.toggle()
                            winnerName = playerName
                        } label: {
                            Image(systemName: "crown")
                        }
                        .rotationEffect(.degrees(90))
                        .font(sizeClassFont)
                        .padding()
                        .blur(radius: popOver ? 2.0 : 0.0)
                        .disabled(popOver ? true : false)
                    }
                } else {
                    HStack {
                        Spacer()
                        ChangeColorButton(popOver: $popOver, font: horizontalSizeClass == .compact ? .title : .custom("iPad", size: 30))
                    }
                    .font(sizeClassFont)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .fontWeight(.semibold)
                }
            } else {
                if !isHalfDown {
                    HStack {
                        Spacer()
                        ChangeColorButton(popOver: $popOver, font: horizontalSizeClass == .compact ? .title : .custom("iPad", size: 30))
                    }
                    .font(sizeClassFont)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .fontWeight(.semibold)
                } else {
                    HStack {
                        PoisonButton(poison: $poison, padding: 8)
                            .rotationEffect(.degrees(90))
                            .scaleEffect(CGSize(width: 1.0, height: 1.0))
                            .blur(radius: popOver ? 2.0 : 0.0)
                        
                        Spacer()
                        
                        Button {
                            someoneWon.toggle()
                            winnerName = playerName
                        } label: {
                            Image(systemName: "crown")
                        }
                        .rotationEffect(.degrees(90))
                        .font(sizeClassFont)
                        .padding()
                        .blur(radius: popOver ? 2.0 : 0.0)
                        .disabled(popOver ? true : false)
                    }
                }
            }
        }
        .shadow(radius: 1)
        .foregroundStyle(.white)
        .background {
            playerColor
                .onTapGesture {
                    viewModel.changeLife = false
                    viewModel.changePlayersNumbers = false
                    popOver = false
                }
        }
        .bold()
    }
}

#Preview {
    SinglePlayerViewHorizontal(playerLife: .constant(20), playerPoisonCounters: .constant(0), playerColor: .constant(.isleColor1), playerName: .constant("Player 1"), changeName: .constant(false), someoneWon: .constant(false), winnerName: .constant(""), fontSize: 150, isLeftSide: true, isHalfDown: false)
        .environmentObject(MainViewVM())
}
