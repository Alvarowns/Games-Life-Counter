//
//  MatchesList.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 29/4/24.
//

import SwiftUI
import SwiftData

struct MatchesList: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Matches.date, order: .reverse) var matches: [Matches]
    
    var body: some View {
        List {
            ForEach(matches, id: \.self) { match in
                VStack(alignment: .leading) {
                    Text("\(match.date.formatted())")
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    ForEach(Array(zip(match.players, match.decks)), id: \.0) { player, deck in
                        HStack {
                            Image(systemName: "crown")
                                .foregroundStyle(.yellow)
                                .opacity(player == match.winner ? 1.0 : 0.0)
                                .font(.footnote)
                            
                            Text(player)
                                .font(.subheadline)
                                .foregroundStyle(player == match.winner ? .yellow : .secondary)
                            
                            Spacer()
                            
                            Text(deck)
                                .font(.subheadline)
                                .foregroundStyle(player == match.winner ? .yellow : .secondary)
                        }
                    }
                }
            }
            .onDelete(perform: deleteMatch(_:))
        }
        .navigationTitle("Matches")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            print(matches.first?.decks ?? "Error")
        }
    }
    
    func deleteMatch(_ indexSet: IndexSet) {
        for index in indexSet {
            let match = matches[index]
            modelContext.delete(match)
        }
    }
}

#Preview {
    MatchesList()
}
