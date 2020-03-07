//
//  Settings.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/24.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class Settings {
    
    static let shared = Settings()
    
    var player1Name: String = "爸"
    var player2Name: String = "妈"
    var player3Name: String = "涵"
    var player4Name: String = "琳"
    
    var player1Color: UIColor = UIColor.random()
    var player2Color: UIColor = UIColor.random()
    var player3Color: UIColor = UIColor.random()
    var player4Color: UIColor = UIColor.random()
    
    var moneyPerPoint: Int = 5
}
