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
            VStack {
                VStack(spacing: 0) {
                    SinglePlayerView(playerName: $viewModel.player1Name, playerLife: $viewModel.player1Life, playerPoisonCounters: $viewModel.player1PoisonCounters, playerColor: $viewModel.player1Color, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName)
                        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .scaleEffect(x: 1, y: -1, anchor: .center)
                    
                    MenuView()
                    
                    SinglePlayerView(playerName: $viewModel.player2Name, playerLife: $viewModel.player2Life, playerPoisonCounters: $viewModel.player2PoisonCounters, playerColor: $viewModel.player2Color, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName)
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

