//
//  Player.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/24.
//  Copyright © 2020 yuhan. All rights reserved.
//

import Foundation

class Player: Codable {
    
    var name: String = ""
    var point: Int = 0
    
    /// win times counter
    var times: Int = 0 
    
    /// continuous win times counter
    var continuous: Int = 0 {
        didSet {
            if continuous > maxContinuous {
                maxContinuous = continuous
            }
        }
    }
    
    /// max continuous win times
    private(set) var maxContinuous: Int = 0 
    
    /// fire for other players counter
    var fires: Int = 0
    
    init(name: String) {
        self.name = name;
    }
} 

extension Player: Hashable {
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
