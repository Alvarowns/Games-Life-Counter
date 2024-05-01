//
//  SinglePlayerView.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 27/4/24.
//

import SwiftUI

struct SinglePlayerViewHorizontal: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
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
    
    var body: some View {
        VStack {
            if isLeftSide {
                if !isHalfDown {
                    HStack {
                        ChangeColorButton(popOver: $popOver, font: .title3)
                        
                        Spacer()
                        
                    }
                    .font(.title3)
                    .padding(.horizontal)
                    .padding(.top)
                    .fontWeight(.semibold)
                } else {
                    HStack {
                        PoisonButton(poison: $poison, padding: 8)
                            .rotationEffect(.degrees(90))
                            .scaleEffect(CGSize(width: 1.0, height: 1.0))
                        
                        Spacer()
                        
                        Image(systemName: "crown")
                            .onTapGesture {
                                someoneWon.toggle()
                                winnerName = playerName
                            }
                            .rotationEffect(.degrees(90))
                            .font(.title3)
                            .padding()
                    }
                }
            } else {
                if !isHalfDown {
                    HStack {
                        PoisonButton(poison: $poison, padding: 8)
                            .rotationEffect(.degrees(90))
                            .scaleEffect(CGSize(width: 1.0, height: 1.0))
                        
                        Spacer()
                        
                        Image(systemName: "crown")
                            .onTapGesture {
                                someoneWon.toggle()
                                winnerName = playerName
                            }
                            .rotationEffect(.degrees(90))
                            .font(.title3)
                            .padding()
                    }
                } else {
                    
                        HStack {
                            ChangeColorButton(popOver: $popOver, font: .title3)
                            
                            Spacer()
                            
                        }
                        .font(.title3)
                        .padding(.horizontal)
                        .padding(.top)
                        .fontWeight(.semibold)
                }
            }
            
            Spacer()
            
            ZStack {
                if !popOver {
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
                            }
                            .foregroundStyle(.black.opacity(0.3))
                            .shadow(color: .black, radius: 1, x: 0, y: 1)
                        }
                        
                        HStack {
                            Spacer()
                            VStack(spacing: 50) {
                                Button {
                                    playerLife -= 1
                                } label: {
                                    Image(systemName: "minus.circle")
                                        .font(.largeTitle)
                                        .rotationEffect(.degrees(90))
                                }
                                
                                Text("\(playerLife)")
                                    .font(.custom("", size: fontSize))
                                    .lineLimit(1)
                                    .rotationEffect(.degrees(90))
                                
                                Button {
                                    playerLife += 1
                                } label: {
                                    Image(systemName: "plus.circle")
                                        .font(.largeTitle)
                                }
                            }
                            
                            Text(playerName)
                                .multilineTextAlignment(.center)
                                .rotationEffect(.degrees(90))
                                .font(.title3)
                                .onTapGesture {
                                    changeName.toggle()
                                }
                        }
                    }
                    
                } else {
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
                            
                            Image(systemName: "crown")
                                .onTapGesture {
                                    someoneWon.toggle()
                                    winnerName = playerName
                                }
                                .rotationEffect(.degrees(90))
                                .font(.title3)
                                .padding()
                    }
                } else {
                        HStack {
                            ChangeColorButton(popOver: $popOver, font: .title3)
                            
                            Spacer()
                            
                        }
                        .font(.title3)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .fontWeight(.semibold)
                }
            } else {
                if !isHalfDown {
                    HStack {
                        ChangeColorButton(popOver: $popOver, font: .title3)
                        
                        Spacer()
                        
                    }
                    .font(.title3)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .fontWeight(.semibold)
                } else {
                    HStack {
                        PoisonButton(poison: $poison, padding: 8)
                            .rotationEffect(.degrees(90))
                            .scaleEffect(CGSize(width: 1.0, height: 1.0))
                        
                        Spacer()
                        
                        Image(systemName: "crown")
                            .onTapGesture {
                                someoneWon.toggle()
                                winnerName = playerName
                            }
                            .rotationEffect(.degrees(90))
                            .font(.title3)
                            .padding()
                    }
                }
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
    SinglePlayerViewHorizontal(playerLife: .constant(20), playerPoisonCounters: .constant(0), playerColor: .constant(.isleColor1), playerName: .constant("Player 1"), changeName: .constant(false), someoneWon: .constant(false), winnerName: .constant(""), fontSize: 150, isLeftSide: true, isHalfDown: false)
        .environmentObject(MainViewVM())
}
