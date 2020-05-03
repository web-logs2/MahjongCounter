//
//  Game.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/24.
//  Copyright © 2020 yuhan. All rights reserved.
//

import Foundation

class Game: Codable {
    
    let createDate: Date
    
    let player1: Player
    let player2: Player
    let player3: Player
    let player4: Player
    
    var isPlaying: Bool = true
    
    var rounds: [Round] = []
    
    init() {
        createDate = Date()
        let settings = Settings.shared;
        player1 = Player(name: settings.player1Name)
        player2 = Player(name: settings.player2Name)
        player3 = Player(name: settings.player3Name)
        player4 = Player(name: settings.player4Name)
    }
}

extension Game: Equatable {
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.createDate == rhs.createDate
    }
}
