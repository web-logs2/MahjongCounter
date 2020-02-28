//
//  Game.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/24.
//  Copyright © 2020 yuhan. All rights reserved.
//

import Foundation

class Game: Codable {
    
    static var current: Game?
    static var hasCheckedUnfinishedGame = false
    
    var player1: Player
    var player2: Player
    var player3: Player
    var player4: Player
    
    init() {
        let settings = Settings.shared;
        player1 = Player(name: settings.player1Name)
        player2 = Player(name: settings.player2Name)
        player3 = Player(name: settings.player3Name)
        player4 = Player(name: settings.player4Name)
    }
    
    private static var gameURL: URL = {
        let path = NSHomeDirectory() + "/Documents/savedGame.plist"
        return URL(fileURLWithPath: path)
    }()
    
    static func saveGame(_ game: Game) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(game) else {
            return
        }
        do {
            try data.write(to: gameURL)
        } catch {
            print(error)
        }
    }
    
    static func clearSavedGame() {
        let manager = FileManager.default
        do {
            try manager.removeItem(at: gameURL)
        } catch {
            print(error)
        }
    }
    
    static func loadUnfinishedGame() -> Game? {
        guard let data = try? Data(contentsOf: gameURL) else {
            return nil
        }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(Game.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
