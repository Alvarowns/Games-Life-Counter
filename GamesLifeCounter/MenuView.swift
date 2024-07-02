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
                    Button {
                        list.toggle()
                    } label: {
                        Image(systemName: "list.bullet.rectangle.portrait")
                    }
                    .navigationDestination(isPresented: $list) {
                        MatchesList()
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.player1Life = viewModel.startingLife
                        viewModel.player2Life = viewModel.startingLife
                        viewModel.player3Life = viewModel.startingLife
                        viewModel.player4Life = viewModel.startingLife
                    } label: {
                        Image(systemName: "arrow.circlepath")
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.changeLife.toggle()
                    } label: {
                        Image(systemName: "heart")
                    }
                    
                    Spacer()
                    
//                    Button {
//                        viewModel.changePlayersNumbers.toggle()
//                    } label: {
//                        Image(systemName: "person.2")
//                    }
//                    
//                    Spacer()
                }
            } else if viewModel.changeLife {
                Group {
                    Spacer()
                    
                    Button {
                        viewModel.startingLife = 20
                        viewModel.player1Life = viewModel.startingLife
                        viewModel.player2Life = viewModel.startingLife
                        viewModel.player3Life = viewModel.startingLife
                        viewModel.player4Life = viewModel.startingLife
                        viewModel.changeLife.toggle()
                    } label: {
                        Text("20")
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.startingLife = 30
                        viewModel.player1Life = viewModel.startingLife
                        viewModel.player2Life = viewModel.startingLife
                        viewModel.player3Life = viewModel.startingLife
                        viewModel.player4Life = viewModel.startingLife
                        viewModel.changeLife.toggle()
                    } label: {
                        Text("30")
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.startingLife = 40
                        viewModel.player1Life = viewModel.startingLife
                        viewModel.player2Life = viewModel.startingLife
                        viewModel.player3Life = viewModel.startingLife
                        viewModel.player4Life = viewModel.startingLife
                        viewModel.changeLife.toggle()
                    } label: {
                        Text("40")
                    }
                    
                    Spacer()
                }
            } else if viewModel.changePlayersNumbers {
                Spacer()
                
                Button {
                    viewModel.numberOfPlayers = 2
                    viewModel.changePlayersNumbers.toggle()
                } label: {
                    Image(systemName: "person.2")
                }
                
                Spacer()
                
                Button {
                    viewModel.numberOfPlayers = 3
                    viewModel.changePlayersNumbers.toggle()
                } label: {
                    Image(systemName: "person.3")
                }
                
                Spacer()
                
                Button {
                    viewModel.numberOfPlayers = 4
                    viewModel.changePlayersNumbers.toggle()
                } label: {
                    ZStack {
                        Image(systemName: "person.2")
                        Image(systemName: "person.2")
                            .offset(x: 35)
                            .rotation3DEffect(
                                .degrees(180),
                                axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                }
                
                Spacer()
            }
        }
        .fontWeight(.semibold)
        .padding(.vertical, 5)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity)
        .font(.title)
        .background(.black)
    }
}

#Preview {
    MenuView()
        .environmentObject(MainViewVM())
}
