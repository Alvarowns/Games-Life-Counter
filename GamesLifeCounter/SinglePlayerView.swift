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
    
    var fontSize: CGFloat
    
    var body: some View {
            VStack {
                HStack {
                    ChangeColorButton(popOver: $popOver, font: .title)
                    
                    Spacer()
                    
                    
                    Image(systemName: "crown")
                        .onTapGesture {
                            someoneWon.toggle()
                            winnerName = playerName
                        }
                }
                .font(.title)
                .padding(.horizontal)
                .padding(.top)
                .fontWeight(.semibold)
                
                Spacer()
                
                ZStack {
                    if !popOver {
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
                                        .font(.largeTitle)
                                }
                                
                                Text("\(playerLife)")
                                    .font(.custom("", size: fontSize))
                                    .lineLimit(1)
                                
                                Button {
                                    playerLife += 1
                                } label: {
                                    Image(systemName: "plus.circle")
                                        .font(.largeTitle)
                                }
                            }
                            
                            if poison {
                                HStack(spacing: 50) {
                                    Button {
                                        playerPoisonCounters -= 1
                                    } label: {
                                        Image(systemName: "minus.circle")
                                            .font(.title)
                                    }
                                    Text("\(playerPoisonCounters)")
                                        .font(.largeTitle)
                                        .lineLimit(1)
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
                        }
                        
                    } else {
                        ChangeColorPalette(popOver: $popOver, playerColor: $playerColor, vertical: true)
                            .padding(.bottom)
                            .padding(.bottom)
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    PoisonButton(poison: $poison, padding: 15)
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
