//
//  PlayerInfoView.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/24.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

protocol PlayerInfoViewDelegate: AnyObject {
    
    func playerInfoView(_ playerInfoView: PlayerInfoView, doneButtonDidClick button: UIButton)
    func playerInfoView(_ playerInfoView: PlayerInfoView, cancelButtonDidClick button: UIButton)
    func playerInfoView(_ playerInfoView: PlayerInfoView, pointButtonDidClick button: UIButton)
    func playerInfoView(_ playerInfoView: PlayerInfoView, fireButtonDidClick button: UIButton)
}

class PlayerInfoView: UIView {
    
    private var nameLabel: UILabel!
    private var winTimesLabel: UILabel!
    private var continuousWinTimesLabel: UILabel!
    private var fireTimesLabel: UILabel!
    private var pointLabel: UILabel!
    
    private var doneButton: UIButton!
    private var cancelButton: UIButton!
    
    private var fireButton: UIButton!
    
    private var pointButton1: UIButton!
    private var pointButton2: UIButton!
    private var pointButton3: UIButton!
    private var pointButton4: UIButton!
    private var pointButton5: UIButton!
    private var pointButton6: UIButton!
    
    private(set) var locked: Bool = false
    
    weak var delegate: PlayerInfoViewDelegate?
    
    var winTimes: Int = 0 {
        didSet {
            updateWinTimes()
        }
    }
    
    var continuousWinTimes: Int = 0 {
        didSet {
            updateContinuousWinTimes()
        }
    }
    
    var fireTimes: Int = 0 {
        didSet {
            updateFireTimes()
        }
    }
    
    var point: Int = 0 {
        didSet {
            updatePoint()
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
        
        continuousWinTimesLabel = UILabel()
        continuousWinTimesLabel.font = UIFont.systemFont(ofSize: 20)
        continuousWinTimesLabel.textColor = UIColor.black
        addSubview(continuousWinTimesLabel)
        
        fireTimesLabel = UILabel()
        fireTimesLabel.font = UIFont.systemFont(ofSize: 20)
        fireTimesLabel.textColor = UIColor.black
        addSubview(fireTimesLabel)
        
        pointLabel = UILabel()
        pointLabel.font = UIFont.systemFont(ofSize: 50)
        addSubview(pointLabel)
        
        let buttonSize = CGSize(width: 60, height: 60)
        
        doneButton = UIButton()
        doneButton.frame.size = buttonSize
        doneButton.layer.cornerRadius = doneButton.frame.width / 2
        doneButton.layer.masksToBounds = true
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        doneButton.setBackgroundImage(UIImage(color: .lightGreen), for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.setTitle("✓", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        addSubview(doneButton)
        
        cancelButton = UIButton()
        cancelButton.frame.size = buttonSize
        cancelButton.layer.cornerRadius = doneButton.frame.width / 2
        cancelButton.layer.masksToBounds = true
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        cancelButton.setBackgroundImage(UIImage(color: .red), for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.setTitle("✗", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        addSubview(cancelButton)
        
        fireButton = UIButton()
        fireButton.frame.size = buttonSize
        fireButton.layer.cornerRadius = fireButton.frame.width / 2
        fireButton.layer.masksToBounds = true
        fireButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        fireButton.setBackgroundImage(UIImage(color: .red), for: .normal)
        fireButton.setBackgroundImage(UIImage(color: .white), for: .selected)
        fireButton.setTitleColor(.white, for: .normal)
        fireButton.setTitleColor(.red, for: .selected)
        fireButton.setTitle("炮", for: .normal)
        fireButton.addTarget(self, action: #selector(fireButtonClicked), for: .touchUpInside)
        addSubview(fireButton)
        
        pointButton1 = UIButton()
        pointButton1.frame.size = buttonSize
        pointButton1.layer.cornerRadius = pointButton1.frame.width / 2
        pointButton1.layer.masksToBounds = true
        pointButton1.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        pointButton1.setBackgroundImage(UIImage(color: .red), for: .normal)
        pointButton1.setBackgroundImage(UIImage(color: .white), for: .selected)
        pointButton1.setTitleColor(.white, for: .normal)
        pointButton1.setTitleColor(.red, for: .selected)
        pointButton1.setTitle("1", for: .normal)
        pointButton1.addTarget(self, action: #selector(pointButton1Clicked), for: .touchUpInside)
        addSubview(pointButton1)
        
        pointButton2 = UIButton()
        pointButton2.frame.size = buttonSize
        pointButton2.layer.cornerRadius = pointButton2.frame.width / 2
        pointButton2.layer.masksToBounds = true
        pointButton2.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        pointButton2.setBackgroundImage(UIImage(color: .red), for: .normal)
        pointButton2.setBackgroundImage(UIImage(color: .white), for: .selected)
        pointButton2.setTitleColor(.white, for: .normal)
        pointButton2.setTitleColor(.red, for: .selected)
        pointButton2.setTitle("2", for: .normal)
        pointButton2.addTarget(self, action: #selector(pointButton2Clicked), for: .touchUpInside)
        addSubview(pointButton2)
        
        pointButton3 = UIButton()
        pointButton3.frame.size = buttonSize
        pointButton3.layer.cornerRadius = pointButton3.frame.width / 2
        pointButton3.layer.masksToBounds = true
        pointButton3.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        pointButton3.setBackgroundImage(UIImage(color: .red), for: .normal)
        pointButton3.setBackgroundImage(UIImage(color: .white), for: .selected)
        pointButton3.setTitleColor(.white, for: .normal)
        pointButton3.setTitleColor(.red, for: .selected)
        pointButton3.setTitle("4", for: .normal)
        pointButton3.addTarget(self, action: #selector(pointButton3Clicked), for: .touchUpInside)
        addSubview(pointButton3)
        
        pointButton4 = UIButton()
        pointButton4.frame.size = buttonSize
        pointButton4.layer.cornerRadius = pointButton4.frame.width / 2
        pointButton4.layer.masksToBounds = true
        pointButton4.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        pointButton4.setBackgroundImage(UIImage(color: .red), for: .normal)
        pointButton4.setBackgroundImage(UIImage(color: .white), for: .selected)
        pointButton4.setTitleColor(.white, for: .normal)
        pointButton4.setTitleColor(.red, for: .selected)
        pointButton4.setTitle("8", for: .normal)
        pointButton4.addTarget(self, action: #selector(pointButton4Clicked), for: .touchUpInside)
        addSubview(pointButton4)
        
        pointButton5 = UIButton()
        pointButton5.frame.size = buttonSize
        pointButton5.layer.cornerRadius = pointButton5.frame.width / 2
        pointButton5.layer.masksToBounds = true
        pointButton5.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        pointButton5.setBackgroundImage(UIImage(color: .red), for: .normal)
        pointButton5.setBackgroundImage(UIImage(color: .white), for: .selected)
        pointButton5.setTitleColor(.white, for: .normal)
        pointButton5.setTitleColor(.red, for: .selected)
        pointButton5.setTitle("16", for: .normal)
        pointButton5.addTarget(self, action: #selector(pointButton5Clicked), for: .touchUpInside)
        addSubview(pointButton5)
        
        pointButton6 = UIButton()
        pointButton6.frame.size = buttonSize
        pointButton6.layer.cornerRadius = pointButton6.frame.width / 2
        pointButton6.layer.masksToBounds = true
        pointButton6.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        pointButton6.setBackgroundImage(UIImage(color: .red), for: .normal)
        pointButton6.setBackgroundImage(UIImage(color: .white), for: .selected)
        pointButton6.setTitleColor(.white, for: .normal)
        pointButton6.setTitleColor(.red, for: .selected)
        pointButton6.setTitle("32", for: .normal)
        pointButton6.addTarget(self, action: #selector(pointButton6Clicked), for: .touchUpInside)
        addSubview(pointButton6)
        
        doneButton.isHidden = true
        cancelButton.isHidden = true
        fireButton.isHidden = true
        pointButton1.isHidden = true
        pointButton2.isHidden = true
        pointButton3.isHidden = true
        pointButton4.isHidden = true
        pointButton5.isHidden = true
        pointButton6.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let space = CGFloat(10)
        let height1 = winTimesLabel.frame.height * 2 + space
        let height2 = pointButton1.frame.height * 2 + space
        
        nameLabel.frame.origin.x = layoutMargins.left
        nameLabel.frame.origin.y = (frame.height - nameLabel.frame.height) / 2
        
        winTimesLabel.frame.origin.x = nameLabel.frame.maxX + 10
        winTimesLabel.frame.origin.y = (frame.height - height1) / 2
        
        continuousWinTimesLabel.frame.origin.x = winTimesLabel.frame.maxX + 10
        continuousWinTimesLabel.frame.origin.y = winTimesLabel.frame.midY - continuousWinTimesLabel.frame.height / 2
        
        fireTimesLabel.frame.origin.x = winTimesLabel.frame.minX
        fireTimesLabel.frame.origin.y = winTimesLabel.frame.maxY + space
        
        pointLabel.frame.origin.x = frame.width - layoutMargins.right - pointLabel.frame.width
        pointLabel.frame.origin.y = (frame.height - pointLabel.frame.height) / 2
        
        cancelButton.frame.origin.x = frame.width - layoutMargins.right - cancelButton.frame.width
        cancelButton.frame.origin.y = (frame.height - cancelButton.frame.height) / 2
        
        doneButton.frame.origin.x = cancelButton.frame.minX - space - doneButton.frame.width
        doneButton.frame.origin.y = (frame.height - doneButton.frame.height) / 2
        
        fireButton.frame.origin.x = nameLabel.frame.maxX + 20
        fireButton.frame.origin.y = (frame.height - fireButton.frame.height) / 2
        
        pointButton3.frame.origin.x = frame.width - layoutMargins.right - pointButton3.frame.width
        pointButton3.frame.origin.y = (frame.height - height2) / 2
        
        pointButton2.frame.origin.x = pointButton3.frame.minX - space - pointButton2.frame.width
        pointButton2.frame.origin.y = pointButton3.frame.minY
        
        pointButton1.frame.origin.x = pointButton2.frame.minX - space - pointButton1.frame.width
        pointButton1.frame.origin.y = pointButton3.frame.minY
        
        pointButton6.frame.origin.x = pointButton3.frame.minX
        pointButton6.frame.origin.y = pointButton3.frame.maxY + space
        
        pointButton5.frame.origin.x = pointButton2.frame.minX
        pointButton5.frame.origin.y = pointButton6.frame.minY
        
        pointButton4.frame.origin.x = pointButton1.frame.minX
        pointButton4.frame.origin.y = pointButton6.frame.minY
    }
    
    func setWinUI() {
        locked = true
        winTimesLabel.isHidden = true
        continuousWinTimesLabel.isHidden = true
        fireTimesLabel.isHidden = true
        pointLabel.isHidden = true
        doneButton.isHidden = false
        cancelButton.isHidden = false
        fireButton.isHidden = true
        pointButton1.isHidden = true
        pointButton2.isHidden = true
        pointButton3.isHidden = true
        pointButton4.isHidden = true
        pointButton5.isHidden = true
        pointButton6.isHidden = true
    }
    
    func setLoseUI() {
        locked = true
        winTimesLabel.isHidden = true
        continuousWinTimesLabel.isHidden = true
        fireTimesLabel.isHidden = true
        pointLabel.isHidden = true
        doneButton.isHidden = true
        cancelButton.isHidden = true
        fireButton.isHidden = false
        pointButton1.isHidden = false
        pointButton2.isHidden = false
        pointButton3.isHidden = false
        pointButton4.isHidden = false
        pointButton5.isHidden = false
        pointButton6.isHidden = false
    }
    
    func resetUI() {
        locked = false
        winTimesLabel.isHidden = false
        continuousWinTimesLabel.isHidden = false
        fireTimesLabel.isHidden = false
        pointLabel.isHidden = false
        doneButton.isHidden = true
        cancelButton.isHidden = true
        fireButton.isHidden = true
        pointButton1.isHidden = true
        pointButton2.isHidden = true
        pointButton3.isHidden = true
        pointButton4.isHidden = true
        pointButton5.isHidden = true
        pointButton6.isHidden = true
    }
    
    func clearFireButtonSelection() {
        fireButton.isSelected = false
    }
    
    func clearPointButtonSelection() {
        updateSelection(withSelectedButton: nil)
    }
    
    private func updateWinTimes() {
        winTimesLabel.text = winTimes.winTimesString
        winTimesLabel.sizeToFit()
        setNeedsLayout()
    }
    
    private func updateContinuousWinTimes() {
        continuousWinTimesLabel.text = continuousWinTimes.continuousWinTimesString
        continuousWinTimesLabel.sizeToFit()
        setNeedsLayout()
    }
    
    private func updateFireTimes() {
        fireTimesLabel.text = fireTimes.fireTimesString
        fireTimesLabel.sizeToFit()
        setNeedsLayout()
    }
    
    private func updatePoint() {
        pointLabel.textColor = point.pointColor
        pointLabel.text = point.pointString;
        pointLabel.sizeToFit()
        setNeedsLayout()
    }
    
    private func didClickPointButton(_ button: UIButton) {
        if button.isSelected {
            return
        }
        updateSelection(withSelectedButton: button)
        delegate?.playerInfoView(self, pointButtonDidClick: button)
    }
     
    @objc private func doneButtonClicked() {
        delegate?.playerInfoView(self, doneButtonDidClick: doneButton)
    }
    
    @objc private func cancelButtonClicked() {
        delegate?.playerInfoView(self, cancelButtonDidClick: cancelButton)
    }
    
    @objc private func fireButtonClicked() {
        if fireButton.isSelected {
            return
        }
        fireButton.isSelected = true
        delegate?.playerInfoView(self, fireButtonDidClick: fireButton)
    }
    
    @objc private func pointButton1Clicked() {
        didClickPointButton(pointButton1)
    }
    
    @objc private func pointButton2Clicked() {
        didClickPointButton(pointButton2)
    }
    
    @objc private func pointButton3Clicked() {
        didClickPointButton(pointButton3)
    }
    
    @objc private func pointButton4Clicked() {
        didClickPointButton(pointButton4)
    }
    
    @objc private func pointButton5Clicked() {
        didClickPointButton(pointButton5)
    }
    
    @objc private func pointButton6Clicked() {
        didClickPointButton(pointButton6)
    }
    
    private func updateSelection(withSelectedButton selectedButton: UIButton?) {
        pointButton1.isSelected = selectedButton === pointButton1
        pointButton2.isSelected = selectedButton === pointButton2
        pointButton3.isSelected = selectedButton === pointButton3
        pointButton4.isSelected = selectedButton === pointButton4
        pointButton5.isSelected = selectedButton === pointButton5
        pointButton6.isSelected = selectedButton === pointButton6
    }
}

extension Int {
    
    var pointColor: UIColor {
        if self < 0 {
            return .red
        }
        if self > 0 {
            return .lightGreen
        }
        return .black
    }
    
    var pointString: String {
        if self > 0 {
            return "+\(self)"
        }
        return String(self)
    }
    
    var winTimesString: String {
        return "胡牌: \(self)"
    }
    
    var continuousWinTimesString: String {
        if self > 0 {
            return "连胡: \(self)"
        }
        return ""
    }
    
    var fireTimesString: String {
        return "点炮: \(self)"
    }
}
