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
        GeometryReader { geometry in
            let width4players = geometry.size.width / 2
            let height4players = geometry.size.height / 2.22
            NavigationStack {
                VStack(spacing: 0) {
                    if viewModel.numberOfPlayers == 2 {
                        SinglePlayerView(playerName: $viewModel.player2Name, playerLife: $viewModel.player2Life, playerPoisonCounters: $viewModel.player2PoisonCounters, playerColor: $viewModel.player2Color, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName, fontSize: 120)
                            .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                            .scaleEffect(x: 1, y: -1, anchor: .center)
                    } else if viewModel.numberOfPlayers == 3 || viewModel.numberOfPlayers == 4 {
                        HStack(spacing: 0) {
                            SinglePlayerViewHorizontal(playerLife: $viewModel.player2Life, playerPoisonCounters: $viewModel.player2PoisonCounters, playerColor: $viewModel.player2Color, playerName: $viewModel.player2Name, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName, fontSize: 60, isLeftSide: true, isHalfDown: false)
                                .frame(width: width4players, height: height4players)
                            
                            SinglePlayerViewHorizontal(playerLife: $viewModel.player3Life, playerPoisonCounters: $viewModel.player3PoisonCounters, playerColor: $viewModel.player3Color, playerName: $viewModel.player3Name, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName, fontSize: 60, isLeftSide: false, isHalfDown: false)
                                .rotationEffect(.degrees(180))
                                .frame(width: width4players, height: height4players)
                        }
                    }
                    
                    MenuView()
                    
                    if viewModel.numberOfPlayers == 2 || viewModel.numberOfPlayers == 3 {
                        SinglePlayerView(playerName: $viewModel.player1Name, playerLife: $viewModel.player1Life, playerPoisonCounters: $viewModel.player1PoisonCounters, playerColor: $viewModel.player1Color, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName, fontSize: 120)
                    } else if viewModel.numberOfPlayers == 4 {
                        HStack(spacing: 0) {
                            SinglePlayerViewHorizontal(playerLife: $viewModel.player1Life, playerPoisonCounters: $viewModel.player1PoisonCounters, playerColor: $viewModel.player1Color, playerName: $viewModel.player1Name, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName, fontSize: 60, isLeftSide: true, isHalfDown: true)
                                .frame(width: width4players, height: height4players)
                            
                            SinglePlayerViewHorizontal(playerLife: $viewModel.player4Life, playerPoisonCounters: $viewModel.player4PoisonCounters, playerColor: $viewModel.player4Color, playerName: $viewModel.player4Name, changeName: $changeName, someoneWon: $winner, winnerName: $winnerName, fontSize: 60, isLeftSide: false, isHalfDown: true)
                                .rotationEffect(.degrees(180))
                                .frame(width: width4players, height: height4players)
                        }
                    }
                    
                    #warning("adUnitId para testing, cambiar a la de producción cuando se haya subido a la App Store.")
                    AdMobBannerView(adUnitId: "ca-app-pub-3940256099942544/2435281174")
                        .frame(width: GADAdSizeBanner.size.width, height: GADAdSizeBanner.size.height)
                }
            }
            .popover(isPresented: $changeName) {
                FormPlayersNames(changeName: $changeName)
            }
            .alert(" \(winnerName) has won?", isPresented: $winner) {
                Button("Yes"){
                    recordMatch(winner: winnerName)
                }
                Button("No", role: .cancel) {}
            }
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

#Preview {
    ContentView()
        .environmentObject(MainViewVM())
}
