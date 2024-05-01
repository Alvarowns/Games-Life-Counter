//
//  FormPlayersNames.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 30/4/24.
//

import SwiftUI

struct FormPlayersNames: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @State private var player1NewName: String = ""
    @State private var player2NewName: String = ""
    @State private var player3NewName: String = ""
    @State private var player4NewName: String = ""

    @State private var player1Deck: String = ""
    @State private var player2Deck: String = ""
    @State private var player3Deck: String = ""
    @State private var player4Deck: String = ""
    
    @Binding var changeName: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Submit") {
                    if !player1NewName.isEmpty {
                        viewModel.player1Name = player1NewName
                        viewModel.player1Deck = player1Deck
                    }
                    if !player2NewName.isEmpty {
                        viewModel.player2Name = player2NewName
                        viewModel.player2Deck = player2Deck
                    }
                    if !player3NewName.isEmpty {
                        viewModel.player3Name = player3NewName
                        viewModel.player3Deck = player3Deck
                    }
                    if !player4NewName.isEmpty {
                        viewModel.player4Name = player4NewName
                        viewModel.player4Deck = player4Deck
                    }
                    
                    player1NewName = ""
                    player2NewName = ""
                    player3NewName = ""
                    player4NewName = ""
                    
                    player1Deck = ""
                    player2Deck = ""
                    player3Deck = ""
                    player4Deck = ""
                    changeName.toggle()
                }
                .padding(.horizontal)
                .padding(.vertical,5)
                .buttonStyle(.borderedProminent)
            }
            
            Form {
                Section {
                    TextField("Change \(viewModel.player1Name) name here", text: $player1NewName)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                    TextField("Player's deck", text: $player1Deck)
                        .autocorrectionDisabled()
                } header: {
                    Text(viewModel.player1Name)
                }
                
                Section {
                    TextField("Change \(viewModel.player2Name) name here", text: $player2NewName)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                    TextField("Player's deck", text: $player2Deck)
                        .autocorrectionDisabled()
                } header: {
                    Text(viewModel.player2Name)
                }
                
                Section {
                    TextField("Change \(viewModel.player3Name) name here", text: $player3NewName)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                    TextField("Player's deck", text: $player3Deck)
                        .autocorrectionDisabled()
                } header: {
                    Text(viewModel.player3Name)
                }
                .opacity(viewModel.numberOfPlayers == 3 || viewModel.numberOfPlayers == 4 ? 1.0 : 0.0)
                
                Section {
                    TextField("Change \(viewModel.player4Name) name here", text: $player4NewName)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                    TextField("Player's deck", text: $player4Deck)
                        .autocorrectionDisabled()
                } header: {
                    Text(viewModel.player4Name)
                }
                .opacity(viewModel.numberOfPlayers == 4 ? 1.0 : 0.0)
            }
        }
    }
}

#Preview {
    FormPlayersNames(changeName: .constant(false))
        .environmentObject(MainViewVM())
}
