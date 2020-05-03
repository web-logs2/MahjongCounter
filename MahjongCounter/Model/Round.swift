//
//  Round.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/5/3.
//  Copyright © 2020 yuhan. All rights reserved.
//

import Foundation

class Round: Codable {
    
    var winner: Player?
    var firer: Player?
    var loserPointInfo: [Player: Int] = [:]
    
    /*
    var winnerID: String = ""
    var firerID: String = ""
    var loserPointInfo: [String: Int] = [:]
    */
}
