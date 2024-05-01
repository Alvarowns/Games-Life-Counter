//
//  Matches.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 29/4/24.
//

import Foundation
import SwiftData

@Model
class Matches {
    var players: [String]
    var decks: [String]
    var date: Date
    var winner: String
    
    init(players: [String] = [], decks: [String] = [], date: Date = .now, winner: String = "") {
        self.players = players
        self.decks = decks
        self.date = date
        self.winner = winner
    }
}
