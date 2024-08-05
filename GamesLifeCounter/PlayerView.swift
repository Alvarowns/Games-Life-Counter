//
//  PlayerView.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 5/7/24.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @Binding var playerName: String
    @Binding var playerLife: Int
    @Binding var playerPoisonCounters: Int
    @Binding var playerColor: Color
    @Binding var changeName: Bool
    @Binding var someoneWon: Bool
    @Binding var winnerName: String
    
    @State private var texture: ImageResource?
    @State private var popOver: Bool = false
    @State private var poison: Bool = false
    @State private var lifesCounter: Int = 0
    @State private var lifesCounterSwitch: Bool = false
    @State private var timer: Timer?
    
    var rotation: CGFloat
    
    var sizeClassFont: Font {
        if horizontalSizeClass == .compact {
            return .custom("iphone", size: 50)
        } else if horizontalSizeClass == .regular {
            return .custom("ipad", size: 100)
        }
        return .custom("iphone", size: 50)
    }
    
    var lifeGreaterThan100: Font {
        if playerLife > 99 {
            return .custom(">99", size: 80)
        } else {
            return .custom("<99", size: 100)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                playerColor
                    .onTapGesture {
                        viewModel.changeLife = false
                        viewModel.changePlayersNumbers = false
                        popOver = false
                    }
                
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
                    .frame(minWidth: geometry.size.height)
                    
                    Button {
                        changeName.toggle()
                    } label: {
                        Text(playerName)
                            .font(horizontalSizeClass == .compact ? .title3 : .custom("ipad", size: 60))
                            .multilineTextAlignment(.center)
                            .fontWeight(.medium)
                    }

                    HStack {
                        Button {
                            playerLife -= 1
                            lifesCounter -= 1
                        } label: {
                            Image(systemName: "minus.circle")
                        }
                        .font(sizeClassFont)
                        .buttonRepeatBehavior(.enabled)
                        .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            Text(lifesCounter > 0 ? "+\(lifesCounter)" : "\(lifesCounter)")
                                .font(.body)
                                .foregroundStyle(.white)
                                .opacity(lifesCounterSwitch && lifesCounter != 0 ? 1.0 : 0.0)
                                .onChange(of: lifesCounter) {
                                    lifesCounterSwitch = true
                                    restartTimer()
                                }
                            
                            Text("\(playerLife)")
                                .font(horizontalSizeClass == .compact ? lifeGreaterThan100 : .custom("ipad", size: 160))
                        }
                        
                        Button {
                            playerLife += 1
                            lifesCounter += 1
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                        .font(sizeClassFont)
                        .buttonRepeatBehavior(.enabled)
                        .padding(.horizontal)
                    }
                    .disabled(popOver ? true : false)
                    .frame(minWidth: geometry.size.height)
                }
                .frame(maxWidth: geometry.size.width / 2, maxHeight: geometry.size.height / 2)
                .foregroundStyle(.white)
                .shadow(radius: 1)
                .blur(radius: popOver ? 2.0 : 0.0)
                .fontWeight(.semibold)
                .font(.largeTitle)
                .rotationEffect(.degrees(rotation))
                
                
                    ChangeColorPalette(popOver: $popOver, playerColor: $playerColor, vertical: false)
                        .rotationEffect(.degrees(rotation))
                        .opacity(popOver ? 1.0 : 0.0)
                        .padding(.bottom)
                        .padding(.bottom)
                
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

#Preview {
    PlayerView(playerName: .constant("Alvarowns"), playerLife: .constant(20), playerPoisonCounters: .constant(0), playerColor: .constant(.plainsColor1), changeName: .constant(false), someoneWon: .constant(false), winnerName: .constant(""), rotation: 90)
        .environmentObject(MainViewVM())
}
