//
//  MenuView.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 27/4/24.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @State private var list: Bool = false
    
    var body: some View {
        HStack {
            if !viewModel.changeLife && !viewModel.changePlayersNumbers {
                Group {
                    Spacer()
                    Image(systemName: "list.bullet.rectangle.portrait")
                        .onTapGesture {
                            list.toggle()
                        }
                        .navigationDestination(isPresented: $list) {
                            MatchesList()
                        }
                    Spacer()
                    Image(systemName: "arrow.circlepath")
                        .onTapGesture {
                            viewModel.player1Life = viewModel.startingLife
                            viewModel.player2Life = viewModel.startingLife
                            viewModel.player3Life = viewModel.startingLife
                            viewModel.player4Life = viewModel.startingLife
                        }
                    Spacer()
                    Image(systemName: "heart")
                        .onTapGesture {
                            viewModel.changeLife.toggle()
                        }
                    Spacer()
                    Image(systemName: "person.2")
                        .onTapGesture {
                            viewModel.changePlayersNumbers.toggle()
                        }
                    Spacer()
                }
            } else if viewModel.changeLife {
                Group {
                    Spacer()
                    Text("20")
                        .onTapGesture {
                            viewModel.startingLife = 20
                            viewModel.player1Life = viewModel.startingLife
                            viewModel.player2Life = viewModel.startingLife
                            viewModel.player3Life = viewModel.startingLife
                            viewModel.player4Life = viewModel.startingLife
                            viewModel.changeLife.toggle()
                        }
                    Spacer()
                    Text("30")
                        .onTapGesture {
                            viewModel.startingLife = 30
                            viewModel.player1Life = viewModel.startingLife
                            viewModel.player2Life = viewModel.startingLife
                            viewModel.player3Life = viewModel.startingLife
                            viewModel.player4Life = viewModel.startingLife
                            viewModel.changeLife.toggle()
                        }
                    Spacer()
                    Text("40")
                        .onTapGesture {
                            viewModel.startingLife = 40
                            viewModel.player1Life = viewModel.startingLife
                            viewModel.player2Life = viewModel.startingLife
                            viewModel.player3Life = viewModel.startingLife
                            viewModel.player4Life = viewModel.startingLife
                            viewModel.changeLife.toggle()
                        }
                    Spacer()
                }
            } else if viewModel.changePlayersNumbers {
                Spacer()
                Image(systemName: "person.2")
                    .onTapGesture {
                        viewModel.numberOfPlayers = 2
                        viewModel.changePlayersNumbers.toggle()
                    }
                Spacer()
                Image(systemName: "person.3")
                    .onTapGesture {
                        viewModel.numberOfPlayers = 3
                        viewModel.changePlayersNumbers.toggle()
                    }
                Spacer()
                ZStack {
                    Image(systemName: "person.2")
                    Image(systemName: "person.2")
                        .offset(x: 35)
                        .rotation3DEffect(
                            .degrees(180),
                            axis: (x: 0.0, y: 1.0, z: 0.0))
                }
                .onTapGesture {
                    viewModel.numberOfPlayers = 4
                    viewModel.changePlayersNumbers.toggle()
                }
                Spacer()
            }
        }
        .fontWeight(.semibold)
        .padding(.vertical, 5)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity)
        .font(.title)
    }
}

#Preview {
    MenuView()
        .environmentObject(MainViewVM())
}
