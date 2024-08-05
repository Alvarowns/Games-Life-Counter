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
    @State private var lifesCounter: Int = 0
    @State private var lifesCounterSwitch: Bool = false
    @State private var timer: Timer?
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var sizeClassFont: Font {
        if horizontalSizeClass == .compact {
            return .custom("iphone", size: 55)
        } else if horizontalSizeClass == .regular {
            return .custom("ipad", size: 100)
        }
        return .custom("iphone", size: 55)
    }
    
    var lifeGreaterThan100: Font {
        if playerLife > 99 {
            return .custom(">99", size: 100)
        } else {
            return .custom("<99", size: 120)
        }
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
                                lifesCounter -= 1
                            } label: {
                                Image(systemName: "minus.circle")
                                    .font(sizeClassFont)
                            }
                            .buttonRepeatBehavior(.enabled)
                            
                            VStack(spacing: 0) {
                                Text(lifesCounter > 0 ? "+\(lifesCounter)" : "\(lifesCounter)")
                                    .shadowPop()
                                    .font(.body)
                                    .foregroundStyle(lifesCounter > 0 ? .white : .red)
                                    .opacity(lifesCounterSwitch && lifesCounter != 0 ? 1.0 : 0.0)
                                    .onChange(of: lifesCounter) {
                                        lifesCounterSwitch = true
                                        restartTimer()
                                    }
                                
                                Text("\(playerLife)")
                                    .font(horizontalSizeClass == .compact ? lifeGreaterThan100 : .custom("ipad", size: 180))
                            }
                            
                            Button {
                                playerLife += 1
                                lifesCounter += 1
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
    
    private func restartTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            lifesCounterSwitch = false
            lifesCounter = 0
        }
    }
}
