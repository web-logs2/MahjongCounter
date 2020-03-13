//
//  ResultViewController.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/25.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {
    
    private var containerView: UIView!
    private var playerResultView1: PlayerResultView!
    private var playerResultView2: PlayerResultView!
    private var playerResultView3: PlayerResultView!
    private var playerResultView4: PlayerResultView!
    
    private var game: Game!
    
    var useCustomBackButton: Bool = false
    
    init(game: Game) {
        super.init(nibName: nil, bundle: nil)
        self.game = game
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "统计"
        if useCustomBackButton {
            navigationItem.leftBarButtonItem = UIBarButtonItem.done(target: self, action: #selector(doneButtonClicked))
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem.action(target: self, action: #selector(actionButtonClicked))
        
        containerView = UIView()
        view.addSubview(containerView)
        
        playerResultView1 = PlayerResultView(name: game.player1.name)
        playerResultView1.backgroundColor = Settings.shared.player1Color
        playerResultView1.winTimes = game.player1.winTimes
        playerResultView1.maxContinuousWinTimes = game.player1.maxContinuousWinTimes
        playerResultView1.ownDrawTimes = game.player1.ownDrawTimes
        playerResultView1.fireTimes = game.player1.fireTimes
        playerResultView1.money = game.player1.point * Settings.shared.moneyPerPoint
        containerView.addSubview(playerResultView1)
        
        playerResultView2 = PlayerResultView(name: game.player2.name)
        playerResultView2.backgroundColor = Settings.shared.player2Color
        playerResultView2.winTimes = game.player2.winTimes
        playerResultView2.maxContinuousWinTimes = game.player2.maxContinuousWinTimes
        playerResultView2.ownDrawTimes = game.player2.ownDrawTimes
        playerResultView2.fireTimes = game.player2.fireTimes
        playerResultView2.money = game.player2.point * Settings.shared.moneyPerPoint
        containerView.addSubview(playerResultView2)
        
        playerResultView3 = PlayerResultView(name: game.player3.name)
        playerResultView3.backgroundColor = Settings.shared.player3Color
        playerResultView3.winTimes = game.player3.winTimes
        playerResultView3.maxContinuousWinTimes = game.player3.maxContinuousWinTimes
        playerResultView3.ownDrawTimes = game.player3.ownDrawTimes
        playerResultView3.fireTimes = game.player3.fireTimes
        playerResultView3.money = game.player3.point * Settings.shared.moneyPerPoint
        containerView.addSubview(playerResultView3)
        
        playerResultView4 = PlayerResultView(name: game.player4.name)
        playerResultView4.backgroundColor = Settings.shared.player4Color
        playerResultView4.winTimes = game.player4.winTimes
        playerResultView4.maxContinuousWinTimes = game.player4.maxContinuousWinTimes
        playerResultView4.ownDrawTimes = game.player4.ownDrawTimes
        playerResultView4.fireTimes = game.player4.fireTimes
        playerResultView4.money = game.player4.point * Settings.shared.moneyPerPoint
        containerView.addSubview(playerResultView4)
        
        updateBestData()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        containerView.frame.origin.x = 0
        containerView.frame.origin.y = view.safeAreaInsets.top
        containerView.frame.size.width = view.frame.width
        containerView.frame.size.height = view.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom
        
        let height = containerView.frame.height / 4
        
        playerResultView1.frame.origin.x = 0
        playerResultView1.frame.origin.y = 0
        playerResultView1.frame.size.width = containerView.frame.width
        playerResultView1.frame.size.height = height
        
        playerResultView2.frame.origin.x = 0
        playerResultView2.frame.origin.y = playerResultView1.frame.maxY
        playerResultView2.frame.size.width = containerView.frame.width
        playerResultView2.frame.size.height = height
        
        playerResultView3.frame.origin.x = 0
        playerResultView3.frame.origin.y = playerResultView2.frame.maxY
        playerResultView3.frame.size.width = containerView.frame.width
        playerResultView3.frame.size.height = height
        
        playerResultView4.frame.origin.x = 0
        playerResultView4.frame.origin.y = playerResultView3.frame.maxY
        playerResultView4.frame.size.width = containerView.frame.width
        playerResultView4.frame.size.height = height
    }
    
    @objc private func actionButtonClicked() {
        guard let image = generateResultImage() else {
            return
        }
        let avc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(avc, animated: true, completion: nil)
    }
    
    @objc private func doneButtonClicked() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func updateBestData() {
        // calculate best data
        let players = [game.player1, game.player2, game.player3, game.player4]
        var maxPoint: Int = 0
        var maxOwnDrawTimes: Int = 0
        var maxFireTimes: Int = 0
        var maxPointIndices: [Int] = []
        var maxOwnDrawTimesIndices: [Int] = []
        var maxFireTimesIndices: [Int] = []
        for (index, player) in players.enumerated() {
            // update point
            if player.point > maxPoint {
                maxPoint = player.point
                maxPointIndices = [index]
            } else if player.point == maxPoint && maxPoint > 0 {
                maxPointIndices.append(index)
            }
            // update own draw times
            if player.ownDrawTimes > maxOwnDrawTimes {
                maxOwnDrawTimes = player.ownDrawTimes
                maxOwnDrawTimesIndices = [index]
            } else if player.ownDrawTimes == maxOwnDrawTimes && maxOwnDrawTimes > 0 {
                maxOwnDrawTimesIndices.append(index)
            }
            // update fire times
            if player.fireTimes > maxFireTimes {
                maxFireTimes = player.fireTimes
                maxFireTimesIndices = [index]
            } else if player.fireTimes == maxFireTimes && maxFireTimes > 0 {
                maxFireTimesIndices.append(index)
            }
        }
        // update UI by best data
        let views: [PlayerResultView] = [playerResultView1, playerResultView2, playerResultView3, playerResultView4]
        for index in maxPointIndices {
            views[index].isBestMoney = true
        }
        for index in maxOwnDrawTimesIndices {
            views[index].isBestDrawer = true
        }
        for index in maxFireTimesIndices {
            views[index].isBestFirer = true
        }
    }
    
    private func generateResultImage() -> UIImage? {
//        UIGraphicsBeginImageContext(containerView.frame.size)
        UIGraphicsBeginImageContextWithOptions(containerView.frame.size, true, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        containerView.drawHierarchy(in: containerView.bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
