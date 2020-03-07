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
}

class PlayerInfoView: UIView {
    
    private var nameLabel: UILabel!
    private var timesLabel: UILabel!
    private var pointLabel: UILabel!
    
    private var doneButton: UIButton!
    private var cancelButton: UIButton!
    
    private var pointButton1: UIButton!
    private var pointButton2: UIButton!
    private var pointButton3: UIButton!
    private var pointButton4: UIButton!
    private var pointButton5: UIButton!
    private var pointButton6: UIButton!
    
    private(set) var locked: Bool = false
    
    weak var delegate: PlayerInfoViewDelegate?

    init(name: String, times: Int, point: Int) {
        super.init(frame: .zero)
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 30)
        nameLabel.textColor = UIColor.black
        nameLabel.text = name;
        nameLabel.sizeToFit()
        addSubview(nameLabel)
        
        timesLabel = UILabel()
        timesLabel.font = UIFont.systemFont(ofSize: 20)
        timesLabel.textColor = UIColor.black
        timesLabel.text = times.timesString;
        timesLabel.sizeToFit()
        addSubview(timesLabel)
        
        pointLabel = UILabel()
        pointLabel.font = UIFont.systemFont(ofSize: 50)
        pointLabel.textColor = point.pointColor
        pointLabel.text = point.pointString;
        pointLabel.sizeToFit()
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
        
        nameLabel.frame.origin.x = (frame.width - nameLabel.frame.width) / 2
        nameLabel.frame.origin.y = 20
        
        timesLabel.frame.origin.x = (frame.width - timesLabel.frame.width) / 2
        timesLabel.frame.origin.y = nameLabel.frame.maxY + 10
        
        pointLabel.frame.origin.x = (frame.width - pointLabel.frame.width) / 2
        pointLabel.frame.origin.y = (frame.height + nameLabel.frame.maxY - pointLabel.frame.height) / 2
        
        let buttonSpace = CGFloat(10)
        let width1 = doneButton.frame.width + buttonSpace + cancelButton.frame.width
        let height1 = doneButton.frame.height
        let width2 = pointButton1.frame.width * 2 + buttonSpace
        let height2 = pointButton1.frame.height * 3 + buttonSpace * 2
        
        doneButton.frame.origin.x = (frame.width - width1) / 2
        doneButton.frame.origin.y = (frame.height + nameLabel.frame.maxY - height1) / 2
        
        cancelButton.frame.origin.x = doneButton.frame.maxX + buttonSpace
        cancelButton.frame.origin.y = doneButton.frame.minY
        
        pointButton1.frame.origin.x = (frame.width - width2) / 2
        pointButton1.frame.origin.y = (frame.height + nameLabel.frame.maxY - height2) / 2
        
        pointButton2.frame.origin.x = pointButton1.frame.maxX + buttonSpace
        pointButton2.frame.origin.y = pointButton1.frame.minY
        
        pointButton3.frame.origin.x = pointButton1.frame.minX
        pointButton3.frame.origin.y = pointButton1.frame.maxY + buttonSpace
        
        pointButton4.frame.origin.x = pointButton3.frame.maxX + buttonSpace
        pointButton4.frame.origin.y = pointButton3.frame.minY
        
        pointButton5.frame.origin.x = pointButton3.frame.minX
        pointButton5.frame.origin.y = pointButton3.frame.maxY + buttonSpace
        
        pointButton6.frame.origin.x = pointButton5.frame.maxX + buttonSpace
        pointButton6.frame.origin.y = pointButton5.frame.minY
    }
    
    func setWinUI() {
        locked = true
        timesLabel.isHidden = true
        pointLabel.isHidden = true
        doneButton.isHidden = false
        cancelButton.isHidden = false
        pointButton1.isHidden = true
        pointButton2.isHidden = true
        pointButton3.isHidden = true
        pointButton4.isHidden = true
        pointButton5.isHidden = true
        pointButton6.isHidden = true
    }
    
    func setLoseUI() {
        locked = true
        timesLabel.isHidden = true
        pointLabel.isHidden = true
        doneButton.isHidden = true
        cancelButton.isHidden = true
        pointButton1.isHidden = false
        pointButton2.isHidden = false
        pointButton3.isHidden = false
        pointButton4.isHidden = false
        pointButton5.isHidden = false
        pointButton6.isHidden = false
    }
    
    func resetUI() {
        locked = false
        timesLabel.isHidden = false
        pointLabel.isHidden = false
        doneButton.isHidden = true
        cancelButton.isHidden = true
        pointButton1.isHidden = true
        pointButton2.isHidden = true
        pointButton3.isHidden = true
        pointButton4.isHidden = true
        pointButton5.isHidden = true
        pointButton6.isHidden = true
    }
    
    func clearPointButtonSelection() {
        updateSelection(withSelectedButton: nil)
    }
    
    func updateTimes(_ times: Int) {
        timesLabel.text = times.timesString
        timesLabel.sizeToFit()
        setNeedsLayout()
    }
    
    func updatePoint(_ point: Int) {
        pointLabel.textColor = point.pointColor
        pointLabel.text = point.pointString;
        pointLabel.sizeToFit()
        setNeedsLayout()
    }
    
    func didClickPointButton(_ button: UIButton) {
        if button.isSelected {
            return
        }
        updateSelection(withSelectedButton: button)
        delegate?.playerInfoView(self, pointButtonDidClick: button)
    }
     
    @objc func doneButtonClicked() {
        delegate?.playerInfoView(self, doneButtonDidClick: doneButton)
    }
    
    @objc func cancelButtonClicked() {
        delegate?.playerInfoView(self, cancelButtonDidClick: cancelButton)
    }
    
    @objc func pointButton1Clicked() {
        didClickPointButton(pointButton1)
    }
    
    @objc func pointButton2Clicked() {
        didClickPointButton(pointButton2)
    }
    
    @objc func pointButton3Clicked() {
        didClickPointButton(pointButton3)
    }
    
    @objc func pointButton4Clicked() {
        didClickPointButton(pointButton4)
    }
    
    @objc func pointButton5Clicked() {
        didClickPointButton(pointButton5)
    }
    
    @objc func pointButton6Clicked() {
        didClickPointButton(pointButton6)
    }
    
    func updateSelection(withSelectedButton selectedButton: UIButton?) {
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
    
    var timesString: String {
        return "胡牌次数: \(self)"
    }
}
