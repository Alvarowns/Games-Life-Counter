//
//  MainViewVM.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 27/4/24.
//

import Foundation
import SwiftUI

@Observable
class MainViewVM: ObservableObject {
    var numberOfPlayers: Int = 2
    
    var player1Life: Int = 20
    var player2Life: Int = 20
    var player3Life: Int = 20
    var player4Life: Int = 20
    
    var player1PoisonCounters: Int = 0
    var player2PoisonCounters: Int = 0
    var player3PoisonCounters: Int = 0
    var player4PoisonCounters: Int = 0
    
    var startingLife: Int = 20
    
    var changeLife: Bool = false
    var changePlayersNumbers: Bool = false
    
    var player1Color: Color = .isleColor1
    var player2Color: Color = .mountainColor1
    var player3Color: Color = .plainsColor1
    var player4Color: Color = .forestColor1
    
    var player1Name: String = "Player 1"
    var player2Name: String = "Player 2"
    var player3Name: String = "Player 3"
    var player4Name: String = "Player 4"
    
    var player1Deck: String = ""
    var player2Deck: String = ""
    var player3Deck: String = ""
    var player4Deck: String = ""
    
    init() {
        numberOfPlayers = 2
        
        player1Life = 20
        player2Life = 20
        player3Life = 20
        player4Life = 20
    }
}
