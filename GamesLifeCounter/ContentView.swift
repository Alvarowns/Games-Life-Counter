//
//  ContentView.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 26/4/24.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    @Environment(\.modelContext) var modelContext
    
    @State private var winner: Bool = false
    @State private var changeName: Bool = false
    @State private var winnerName: String = ""
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    if viewModel.numberOfPlayers == 3 || viewModel.numberOfPlayers == 4 {
                        HStack(spacing: 0) {
                            PlayerView(playerName: $viewModel.player2Name, playerLife: $viewModel.player2Life, playerPoisonCounters: $viewModel.player2PoisonCounters, playerColor: $viewModel.player2Color, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName, rotation: 90)
                            
                            PlayerView(playerName: $viewModel.player3Name, playerLife: $viewModel.player3Life, playerPoisonCounters: $viewModel.player3PoisonCounters, playerColor: $viewModel.player3Color, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName, rotation: -90)
                        }
                    } else if viewModel.numberOfPlayers == 2 {
                        SinglePlayerView(playerName: $viewModel.player2Name, playerLife: $viewModel.player2Life, playerPoisonCounters: $viewModel.player2PoisonCounters, playerColor: $viewModel.player2Color, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName)
                            .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                            .scaleEffect(x: 1, y: -1, anchor: .center)
                    }
                    
                    MenuView()
                    
                    if viewModel.numberOfPlayers == 4 {
                        HStack(spacing: 0) {
                            PlayerView(playerName: $viewModel.player1Name, playerLife: $viewModel.player1Life, playerPoisonCounters: $viewModel.player1PoisonCounters, playerColor: $viewModel.player1Color, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName, rotation: 90)
                            .frame(maxWidth: geometry.size.width / 2, maxHeight: geometry.size.height / 2)
                            
                            PlayerView(playerName: $viewModel.player4Name, playerLife: $viewModel.player4Life, playerPoisonCounters: $viewModel.player4PoisonCounters, playerColor: $viewModel.player4Color, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName, rotation: -90)
                                .frame(maxWidth: geometry.size.width / 2, maxHeight: geometry.size.height / 2)
                        }
                    } else {
                        SinglePlayerView(playerName: $viewModel.player1Name, playerLife: $viewModel.player1Life, playerPoisonCounters: $viewModel.player1PoisonCounters, playerColor: $viewModel.player1Color, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName)
                    }
                }
            }
            .sheet(isPresented: $changeName) {
                FormPlayersNames(changeName: $changeName)
            }
            .alert(" \(winnerName) has won?", isPresented: $winner) {
                Button("Yes"){
                    recordMatch(winner: winnerName)
                }
                Button("No", role: .cancel) {}
            }
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
    
    func recordMatch(winner: String) {
        var players = [viewModel.player1Name, viewModel.player2Name]
        var decks = [viewModel.player1Deck, viewModel.player2Deck]
        
        if viewModel.numberOfPlayers == 3 {
            players.append(viewModel.player3Name)
            decks.append(viewModel.player3Deck)
        }
        if viewModel.numberOfPlayers == 4 {
            players.append(viewModel.player3Name)
            players.append(viewModel.player4Name)
            decks.append(viewModel.player3Deck)
            decks.append(viewModel.player4Deck)
        }
        
        let match = Matches(players: players, decks: decks, date: .now, winner: winner)
        modelContext.insert(match)
        
        viewModel.player1Life = viewModel.startingLife
        viewModel.player2Life = viewModel.startingLife
        viewModel.player3Life = viewModel.startingLife
        viewModel.player4Life = viewModel.startingLife
    }
}

