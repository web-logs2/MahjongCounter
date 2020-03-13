//
//  GameStore.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/3/10.
//  Copyright © 2020 yuhan. All rights reserved.
//

import Foundation

protocol GameStoreObservering: AnyObject {
    
    func gamesDidUpdate(_ games: [Game])
}

class GameStore {
    
    private static var observers: NSHashTable<AnyObject> = {
        let table = NSHashTable<AnyObject>(options: .weakMemory)
        return table
    }()
    
    static func addObserver(_ observer: GameStoreObservering) {
        observers.add(observer)
    }
    
    static func removeObserver(_ observer: GameStoreObservering) {
        observers.remove(observer)
    }
    
    private(set) static var games: [Game] = []
    
    static func loadGamesFromLocal() {
        do {
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: gamesURL)
            games = try decoder.decode([Game].self, from: data)
            gamesDidUpdate()
        } catch {
            print(error)
        }
    }
    
    private static func saveGamesToLocal() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(games)
            try data.write(to: gamesURL)
        } catch {
            print(error)
        }
    }
    
    static func addGame(_ game: Game) {
        games.insert(game, at: 0)
        gamesDidUpdate()
    }
    
    static func updateGame(_ game: Game) {
        if let index = games.firstIndex(of: game) {
            games[index] = game
            gamesDidUpdate()
        }
    }
    
    static func deleteGame(_ game: Game) {
        if let index = games.firstIndex(of: game) {
            games.remove(at: index)
            gamesDidUpdate()
        }
    }
    
    private static var gamesURL: URL = {
        let path = NSHomeDirectory() + "/Documents/games.plist"
        return URL(fileURLWithPath: path)
    }()
    
    private static func gamesDidUpdate() {
        for object in observers.allObjects {
            if let observer = object as? GameStoreObservering {
                observer.gamesDidUpdate(games)
            }
        }
        saveGamesToLocal()
    }
}
