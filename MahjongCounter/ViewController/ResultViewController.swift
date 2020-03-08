//
//  ResultViewController.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/25.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    private var nameLabel1: UILabel!
    private var nameLabel2: UILabel!
    private var nameLabel3: UILabel!
    private var nameLabel4: UILabel!
    private var moneyLabel1: UILabel!
    private var moneyLabel2: UILabel!
    private var moneyLabel3: UILabel!
    private var moneyLabel4: UILabel!
    private var timesLabel: UILabel!
    private var continuousLabel: UILabel!
    private var actionButton: UIButton!
    private var endButton: UIButton!
    
    private var game: Game!
    
    var didFinishHandler: (() -> Void)?
    
    init(game: Game) {
        super.init(nibName: nil, bundle: nil)
        self.game = game
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let player1 = game.player1
        let player2 = game.player2
        let player3 = game.player3
        let player4 = game.player4
        
        nameLabel1 = UILabel()
        nameLabel1.font = UIFont.systemFont(ofSize: 24)
        nameLabel1.textColor = UIColor.black
        nameLabel1.text = "\(player1.name)(\(player1.times)): "
        nameLabel1.sizeToFit()
        view.addSubview(nameLabel1)
        
        nameLabel2 = UILabel()
        nameLabel2.font = UIFont.systemFont(ofSize: 24)
        nameLabel2.textColor = UIColor.black
        nameLabel2.text = "\(player2.name)(\(player2.times)): "
        nameLabel2.sizeToFit()
        view.addSubview(nameLabel2)
        
        nameLabel3 = UILabel()
        nameLabel3.font = UIFont.systemFont(ofSize: 24)
        nameLabel3.textColor = UIColor.black
        nameLabel3.text = "\(player3.name)(\(player3.times)): "
        nameLabel3.sizeToFit()
        view.addSubview(nameLabel3)
        
        nameLabel4 = UILabel()
        nameLabel4.font = UIFont.systemFont(ofSize: 24)
        nameLabel4.textColor = UIColor.black
        nameLabel4.text = "\(player4.name)(\(player4.times)): "
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
        
        timesLabel = UILabel()
        timesLabel.font = UIFont.systemFont(ofSize: 20)
        timesLabel.textColor = UIColor.black
        timesLabel.text = generateTimesString()
        timesLabel.sizeToFit()
        view.addSubview(timesLabel)
        
        continuousLabel = UILabel()
        continuousLabel.font = UIFont.systemFont(ofSize: 20)
        continuousLabel.textColor = UIColor.black
        continuousLabel.text = generateContinuousString()
        continuousLabel.sizeToFit()
        view.addSubview(continuousLabel)
        
        actionButton = UIButton()
        actionButton.layer.cornerRadius = 8
        actionButton.layer.masksToBounds = true
        actionButton.frame.size = CGSize(width: 300, height: 50)
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        actionButton.setBackgroundImage(UIImage(color: .orange), for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.setTitle("分享", for: .normal)
        actionButton.addTarget(self, action: #selector(actionButtonClicked), for: .touchUpInside)
        view.addSubview(actionButton)
        
        endButton = UIButton()
        endButton.layer.cornerRadius = 8
        endButton.layer.masksToBounds = true
        endButton.frame.size = CGSize(width: 300, height: 50)
        endButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        endButton.setBackgroundImage(UIImage(color: .systemBlue), for: .normal)
        endButton.setTitleColor(.white, for: .normal)
        endButton.setTitle("结束", for: .normal)
        endButton.addTarget(self, action: #selector(endButtonClicked), for: .touchUpInside)
        view.addSubview(endButton)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        let labelSpace1 = CGFloat(20)
        let connectSpace1 = CGFloat(40)
        let labelSpace2 = CGFloat(10)
        let connectSpace2 = CGFloat(80)
        let buttonSpace = CGFloat(20)
        let labelsHeight1 = nameLabel1.frame.height * 4 + labelSpace1 * 3
        let labelsHeight2 = timesLabel.frame.height * 2 + labelSpace1
        let buttonsHeight = actionButton.frame.height + buttonSpace + endButton.frame.height
        let height = labelsHeight1 + connectSpace1 + labelsHeight2 + connectSpace2 + buttonsHeight
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
        
        timesLabel.frame.origin.x = centerX - timesLabel.frame.width / 2
        timesLabel.frame.origin.y = nameLabel4.frame.maxY + connectSpace1
        
        continuousLabel.frame.origin.x = centerX - continuousLabel.frame.width / 2
        continuousLabel.frame.origin.y = timesLabel.frame.maxY + labelSpace2
        
        actionButton.frame.origin.x = centerX - actionButton.frame.width / 2
        actionButton.frame.origin.y = continuousLabel.frame.maxY + connectSpace2
        
        endButton.frame.origin.x = centerX - endButton.frame.width / 2
        endButton.frame.origin.y = actionButton.frame.maxY + buttonSpace
    }
    
    func generateTimesString() -> String {
        var maxTimes: Int = 0
        var maxPlayers: [Player] = []
        let players = [game.player1, game.player2, game.player3, game.player4]
        for player in players {
            if player.times > maxTimes {
                maxTimes = player.times
                maxPlayers = [player]
            } else if player.times == maxTimes {
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
    
    func generateContinuousString() -> String {
        var maxContinuous: Int = 0
        var maxPlayers: [Player] = []
        let players = [game.player1, game.player2, game.player3, game.player4]
        for player in players {
            if player.maxContinuous > maxContinuous {
                maxContinuous = player.maxContinuous
                maxPlayers = [player]
            } else if player.maxContinuous == maxContinuous {
                maxPlayers.append(player)
            }
        }
        var string = "连胡最多 \(maxContinuous)次: "
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
        let h = continuousLabel.frame.maxY - nameLabel1.frame.minY + 20
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
    
    @objc func endButtonClicked() {
        dismiss(animated: true) { 
            self.didFinishHandler?()
        }
    }
}
