//
//  PlayerResultView.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/3/10.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class PlayerResultView: UIView {

    private var nameLabel: UILabel!
    private var winTimesLabel: UILabel!
    private var maxContinuousWinTimesLabel: UILabel!
    private var ownDrawTimesLabel: UILabel!
    private var fireTimesLabel: UILabel!
    private var moneyLabel: UILabel!
    
    private var bestMoneyLabel: UILabel!
    private var bestDrawerLabel: UILabel!
    private var bestFirerLabel: UILabel!
    
    var winTimes: Int = 0 {
        didSet {
            updateWinTimes()
        }
    }
    
    var maxContinuousWinTimes: Int = 0 {
        didSet {
            updateMaxContinuousWinTimes()
        }
    }
    
    var ownDrawTimes: Int = 0 {
        didSet {
            updateOwnDrawTimes()
        }
    }
    
    var fireTimes: Int = 0 {
        didSet {
            updateFireTimes()
        }
    }
    
    var money: Int = 0 {
        didSet {
            updateMoney()
        }
    }
    
    var isBestMoney: Bool = false {
        didSet {
            bestMoneyLabel.isHidden = !isBestMoney
        }
    }
    
    var isBestDrawer: Bool = false {
        didSet {
            bestDrawerLabel.isHidden = !isBestDrawer
        }
    }
    
    var isBestFirer: Bool = false {
        didSet {
            bestFirerLabel.isHidden = !isBestFirer
        }
    }

    init(name: String) {
        super.init(frame: .zero)
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 30)
        nameLabel.textColor = UIColor.black
        nameLabel.text = name;
        nameLabel.sizeToFit()
        addSubview(nameLabel)
        
        winTimesLabel = UILabel()
        winTimesLabel.font = UIFont.systemFont(ofSize: 20)
        winTimesLabel.textColor = UIColor.black
        addSubview(winTimesLabel)
        
        maxContinuousWinTimesLabel = UILabel()
        maxContinuousWinTimesLabel.font = UIFont.systemFont(ofSize: 20)
        maxContinuousWinTimesLabel.textColor = UIColor.black
        addSubview(maxContinuousWinTimesLabel)
        
        ownDrawTimesLabel = UILabel()
        ownDrawTimesLabel.font = UIFont.systemFont(ofSize: 20)
        ownDrawTimesLabel.textColor = UIColor.black
        addSubview(ownDrawTimesLabel)
        
        fireTimesLabel = UILabel()
        fireTimesLabel.font = UIFont.systemFont(ofSize: 20)
        fireTimesLabel.textColor = UIColor.black
        addSubview(fireTimesLabel)
        
        moneyLabel = UILabel()
        moneyLabel.font = UIFont.systemFont(ofSize: 50)
        addSubview(moneyLabel)
        
        bestMoneyLabel = UILabel()
        bestMoneyLabel.font = UIFont.systemFont(ofSize: 20)
        bestMoneyLabel.text = "👑"
        bestMoneyLabel.sizeToFit()
        addSubview(bestMoneyLabel)
        
        bestDrawerLabel = UILabel()
        bestDrawerLabel.font = UIFont.systemFont(ofSize: 20)
        bestDrawerLabel.text = "🎖" // 🖐🏅🎖
        bestDrawerLabel.sizeToFit()
        addSubview(bestDrawerLabel)
        
        bestFirerLabel = UILabel()
        bestFirerLabel.font = UIFont.systemFont(ofSize: 20)
        bestFirerLabel.text = "🧨"
        bestFirerLabel.sizeToFit()
        addSubview(bestFirerLabel)
        
        bestMoneyLabel.isHidden = true
        bestDrawerLabel.isHidden = true
        bestFirerLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let space = CGFloat(10)
        let height = winTimesLabel.frame.height * 3 + space * 2
        
        nameLabel.frame.origin.x = layoutMargins.left
        nameLabel.frame.origin.y = (frame.height - nameLabel.frame.height) / 2
        
        winTimesLabel.frame.origin.x = nameLabel.frame.maxX + 10
        winTimesLabel.frame.origin.y = (frame.height - height) / 2
        
        maxContinuousWinTimesLabel.frame.origin.x = winTimesLabel.frame.maxX + 10
        maxContinuousWinTimesLabel.frame.origin.y = winTimesLabel.frame.midY - maxContinuousWinTimesLabel.frame.height / 2
        
        ownDrawTimesLabel.frame.origin.x = winTimesLabel.frame.minX
        ownDrawTimesLabel.frame.origin.y = winTimesLabel.frame.maxY + space
        
        fireTimesLabel.frame.origin.x = winTimesLabel.frame.minX
        fireTimesLabel.frame.origin.y = ownDrawTimesLabel.frame.maxY + space
        
        moneyLabel.frame.origin.x = frame.width - layoutMargins.right - moneyLabel.frame.width
        moneyLabel.frame.origin.y = (frame.height - moneyLabel.frame.height) / 2
        
        bestMoneyLabel.frame.origin.x = nameLabel.frame.midX - bestMoneyLabel.frame.width / 2
        bestMoneyLabel.frame.origin.y = nameLabel.frame.minY - bestMoneyLabel.frame.height
        
        bestDrawerLabel.frame.origin.x = ownDrawTimesLabel.frame.maxX + 10
        bestDrawerLabel.frame.origin.y = ownDrawTimesLabel.frame.midY - bestDrawerLabel.frame.height / 2
        
        bestFirerLabel.frame.origin.x = fireTimesLabel.frame.maxX + 10
        bestFirerLabel.frame.origin.y = fireTimesLabel.frame.midY - bestFirerLabel.frame.height / 2
    }
    
    private func updateWinTimes() {
        winTimesLabel.text = winTimes.winTimesString
        winTimesLabel.sizeToFit()
        setNeedsLayout()
    }
    
    private func updateMaxContinuousWinTimes() {
        maxContinuousWinTimesLabel.text = maxContinuousWinTimes.maxContinuousWinTimesString
        maxContinuousWinTimesLabel.sizeToFit()
        setNeedsLayout()
    }
    
    private func updateOwnDrawTimes() {
        ownDrawTimesLabel.text = ownDrawTimes.ownDrawTimesString
        ownDrawTimesLabel.sizeToFit()
        setNeedsLayout()
    }
    
    private func updateFireTimes() {
        fireTimesLabel.text = fireTimes.fireTimesString
        fireTimesLabel.sizeToFit()
        setNeedsLayout()
    }
    
    private func updateMoney() {
        moneyLabel.textColor = money.pointColor
        moneyLabel.text = money.pointString;
        moneyLabel.sizeToFit()
        setNeedsLayout()
    }
}
