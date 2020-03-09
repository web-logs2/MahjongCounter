//
//  ResultViewController.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/25.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {
    
    private var nameLabel1: UILabel!
    private var nameLabel2: UILabel!
    private var nameLabel3: UILabel!
    private var nameLabel4: UILabel!
    private var moneyLabel1: UILabel!
    private var moneyLabel2: UILabel!
    private var moneyLabel3: UILabel!
    private var moneyLabel4: UILabel!
    private var maxWinTimesLabel: UILabel!
    private var maxContinuousWinTimesLabel: UILabel!
    private var maxFireTimesLabel: UILabel!
    
    private var game: Game!
    
    init(game: Game) {
        super.init(nibName: nil, bundle: nil)
        self.game = game
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "结果"
        navigationItem.leftBarButtonItem = UIBarButtonItem.action(target: self, action: #selector(actionButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem.done(target: self, action: #selector(doneButtonClicked))
        
        let player1 = game.player1
        let player2 = game.player2
        let player3 = game.player3
        let player4 = game.player4
        
        nameLabel1 = UILabel()
        nameLabel1.font = UIFont.systemFont(ofSize: 24)
        nameLabel1.textColor = UIColor.black
        nameLabel1.text = "\(player1.name)(\(player1.winTimes)): "
        nameLabel1.sizeToFit()
        view.addSubview(nameLabel1)
        
        nameLabel2 = UILabel()
        nameLabel2.font = UIFont.systemFont(ofSize: 24)
        nameLabel2.textColor = UIColor.black
        nameLabel2.text = "\(player2.name)(\(player2.winTimes)): "
        nameLabel2.sizeToFit()
        view.addSubview(nameLabel2)
        
        nameLabel3 = UILabel()
        nameLabel3.font = UIFont.systemFont(ofSize: 24)
        nameLabel3.textColor = UIColor.black
        nameLabel3.text = "\(player3.name)(\(player3.winTimes)): "
        nameLabel3.sizeToFit()
        view.addSubview(nameLabel3)
        
        nameLabel4 = UILabel()
        nameLabel4.font = UIFont.systemFont(ofSize: 24)
        nameLabel4.textColor = UIColor.black
        nameLabel4.text = "\(player4.name)(\(player4.winTimes)): "
        nameLabel4.sizeToFit()
        view.addSubview(nameLabel4)
        
        let settings = Settings.shared
        
        moneyLabel1 = UILabel()
        moneyLabel1.font = UIFont.systemFont(ofSize: 36)
        moneyLabel1.textColor = player1.point.pointColor
        moneyLabel1.text = (player1.point * settings.moneyPerPoint).pointString
        moneyLabel1.sizeToFit()
        view.addSubview(moneyLabel1)
        
        moneyLabel2 = UILabel()
        moneyLabel2.font = UIFont.systemFont(ofSize: 36)
        moneyLabel2.textColor = player2.point.pointColor
        moneyLabel2.text = (player2.point * settings.moneyPerPoint).pointString
        moneyLabel2.sizeToFit()
        view.addSubview(moneyLabel2)
        
        moneyLabel3 = UILabel()
        moneyLabel3.font = UIFont.systemFont(ofSize: 36)
        moneyLabel3.textColor = player3.point.pointColor
        moneyLabel3.text = (player3.point * settings.moneyPerPoint).pointString
        moneyLabel3.sizeToFit()
        view.addSubview(moneyLabel3)
        
        moneyLabel4 = UILabel()
        moneyLabel4.font = UIFont.systemFont(ofSize: 36)
        moneyLabel4.textColor = player4.point.pointColor
        moneyLabel4.text = (player4.point * settings.moneyPerPoint).pointString
        moneyLabel4.sizeToFit()
        view.addSubview(moneyLabel4)
        
        maxWinTimesLabel = UILabel()
        maxWinTimesLabel.font = UIFont.systemFont(ofSize: 20)
        maxWinTimesLabel.textColor = UIColor.black
        maxWinTimesLabel.text = generateMaxWinTimesString()
        maxWinTimesLabel.sizeToFit()
        view.addSubview(maxWinTimesLabel)
        
        maxContinuousWinTimesLabel = UILabel()
        maxContinuousWinTimesLabel.font = UIFont.systemFont(ofSize: 20)
        maxContinuousWinTimesLabel.textColor = UIColor.black
        maxContinuousWinTimesLabel.text = generateMaxContinuousWinTimesString()
        maxContinuousWinTimesLabel.sizeToFit()
        view.addSubview(maxContinuousWinTimesLabel)
        
        maxFireTimesLabel = UILabel()
        maxFireTimesLabel.font = UIFont.systemFont(ofSize: 20)
        maxFireTimesLabel.textColor = UIColor.black
        maxFireTimesLabel.text = generateFireTimesLabelString()
        maxFireTimesLabel.sizeToFit()
        view.addSubview(maxFireTimesLabel)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        let labelSpace1 = CGFloat(20)
        let labelSpace2 = CGFloat(10)
        let labelsHeight1 = nameLabel1.frame.height * 4 + labelSpace1 * 3
        let labelsHeight2 = maxWinTimesLabel.frame.height * 3 + labelSpace1 * 2
        let connectSpace = CGFloat(40)
        let height = labelsHeight1 + connectSpace + labelsHeight2
        let centerX = (view.frame.width + view.safeAreaInsets.left - view.safeAreaInsets.right) / 2
        
        nameLabel1.frame.origin.x = centerX - nameLabel1.frame.width
        nameLabel1.frame.origin.y = (view.frame.height - height) / 2
        
        nameLabel2.frame.origin.x = centerX - nameLabel2.frame.width
        nameLabel2.frame.origin.y = nameLabel1.frame.maxY + labelSpace1
        
        nameLabel3.frame.origin.x = centerX - nameLabel3.frame.width
        nameLabel3.frame.origin.y = nameLabel2.frame.maxY + labelSpace1
        
        nameLabel4.frame.origin.x = centerX - nameLabel4.frame.width
        nameLabel4.frame.origin.y = nameLabel3.frame.maxY + labelSpace1
        
        moneyLabel1.frame.origin.x = nameLabel1.frame.maxX
        moneyLabel1.frame.origin.y = nameLabel1.frame.midY - moneyLabel1.frame.height / 2
        
        moneyLabel2.frame.origin.x = nameLabel2.frame.maxX
        moneyLabel2.frame.origin.y = nameLabel2.frame.midY - moneyLabel2.frame.height / 2
        
        moneyLabel3.frame.origin.x = nameLabel3.frame.maxX
        moneyLabel3.frame.origin.y = nameLabel3.frame.midY - moneyLabel3.frame.height / 2
        
        moneyLabel4.frame.origin.x = nameLabel4.frame.maxX
        moneyLabel4.frame.origin.y = nameLabel4.frame.midY - moneyLabel4.frame.height / 2
        
        maxWinTimesLabel.frame.origin.x = centerX - maxWinTimesLabel.frame.width / 2
        maxWinTimesLabel.frame.origin.y = nameLabel4.frame.maxY + connectSpace
        
        maxContinuousWinTimesLabel.frame.origin.x = centerX - maxContinuousWinTimesLabel.frame.width / 2
        maxContinuousWinTimesLabel.frame.origin.y = maxWinTimesLabel.frame.maxY + labelSpace2
        
        maxFireTimesLabel.frame.origin.x = centerX - maxFireTimesLabel.frame.width / 2
        maxFireTimesLabel.frame.origin.y = maxContinuousWinTimesLabel.frame.maxY + labelSpace2
    }
    
    func generateMaxWinTimesString() -> String {
        var maxTimes: Int = 0
        var maxPlayers: [Player] = []
        let players = [game.player1, game.player2, game.player3, game.player4]
        for player in players {
            if player.winTimes > maxTimes {
                maxTimes = player.winTimes
                maxPlayers = [player]
            } else if player.winTimes == maxTimes {
                maxPlayers.append(player)
            }
        }
        var string = "胡牌最多 \(maxTimes)次: "
        for (index, player) in maxPlayers.enumerated() {
            if index > 0 {
                string += "/"
            }
            string += player.name
        }
        return string
    }
    
    func generateMaxContinuousWinTimesString() -> String {
        var maxTimes: Int = 0
        var maxPlayers: [Player] = []
        let players = [game.player1, game.player2, game.player3, game.player4]
        for player in players {
            if player.maxContinuousWinTimes > maxTimes {
                maxTimes = player.maxContinuousWinTimes
                maxPlayers = [player]
            } else if player.maxContinuousWinTimes == maxTimes {
                maxPlayers.append(player)
            }
        }
        var string = "连胡最多 \(maxTimes)次: "
        for (index, player) in maxPlayers.enumerated() {
            if index > 0 {
                string += "/"
            }
            string += player.name
        }
        return string
    }
    
    func generateFireTimesLabelString() -> String {
        var maxTimes: Int = 0
        var maxPlayers: [Player] = []
        let players = [game.player1, game.player2, game.player3, game.player4]
        for player in players {
            if player.fireTimes > maxTimes {
                maxTimes = player.fireTimes
                maxPlayers = [player]
            } else if player.fireTimes == maxTimes {
                maxPlayers.append(player)
            }
        }
        var string = "点炮最多 \(maxTimes)次: "
        for (index, player) in maxPlayers.enumerated() {
            if index > 0 {
                string += "/"
            }
            string += player.name
        }
        return string
    }
    
    func generateResultImage() -> UIImage? {
        UIGraphicsBeginImageContext(view.frame.size)
        defer {
            UIGraphicsEndImageContext()
        }
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let x = nameLabel1.frame.maxX - 100
        let y = nameLabel1.frame.minY - 10
        let w = CGFloat(220)
        let h = maxFireTimesLabel.frame.maxY - nameLabel1.frame.minY + 20
        let rect = CGRect(x: x, y: y, width: w, height: h)
        return image?.cropping(to: rect)
    }
    
    @objc func actionButtonClicked() {
        guard let image = generateResultImage() else {
            return
        }
        let avc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(avc, animated: true, completion: nil)
    }
    
    @objc func doneButtonClicked() {
        navigationController?.popToRootViewController(animated: true)
    }
}
