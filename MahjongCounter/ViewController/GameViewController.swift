//
//  GameViewController.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/24.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class GameViewController: BaseViewController {
    
    private var player1InfoView: PlayerInfoView!
    private var player2InfoView: PlayerInfoView!
    private var player3InfoView: PlayerInfoView!
    private var player4InfoView: PlayerInfoView!
    
    private var game: Game!
    private var currentRoundWinner: Player?
    private var currentRoundFirer: Player?
    private var currentRoundLoserPointInfo: [Player: Int] = [:]
    private var locked: Bool {
        if player1InfoView.locked {
            return true
        }
        if player2InfoView.locked {
            return true
        }
        if player3InfoView.locked {
            return true
        }
        if player4InfoView.locked {
            return true
        }
        return false
    }
    
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
        
        navigationItem.title = "详情"
        navigationItem.rightBarButtonItem = UIBarButtonItem.end(target: self, action: #selector(endButtonClicked))
        
        player1InfoView = PlayerInfoView(name: game.player1.name)
        player1InfoView.backgroundColor = Settings.shared.player1Color
        player1InfoView.addTapGestureRecognizer(target: self, action: #selector(player1InfoViewTapped))
        player1InfoView.delegate = self
        view.addSubview(player1InfoView)
        
        player2InfoView = PlayerInfoView(name: game.player2.name)
        player2InfoView.backgroundColor = Settings.shared.player2Color
        player2InfoView.addTapGestureRecognizer(target: self, action: #selector(player2InfoViewTapped))
        player2InfoView.delegate = self
        view.addSubview(player2InfoView)
        
        player3InfoView = PlayerInfoView(name: game.player3.name)
        player3InfoView.backgroundColor = Settings.shared.player3Color
        player3InfoView.addTapGestureRecognizer(target: self, action: #selector(player3InfoViewTapped))
        player3InfoView.delegate = self
        view.addSubview(player3InfoView)
        
        player4InfoView = PlayerInfoView(name: game.player4.name)
        player4InfoView.backgroundColor = Settings.shared.player4Color
        player4InfoView.addTapGestureRecognizer(target: self, action: #selector(player4InfoViewTapped))
        player4InfoView.delegate = self
        view.addSubview(player4InfoView)
        
        updatePlayerInfoViewsData()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        let width = view.frame.width
        let height = (view.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom) / 4
        
        player1InfoView.frame.origin.y = view.safeAreaInsets.top
        player1InfoView.frame.size = CGSize(width: width, height: height)
        
        player2InfoView.frame.origin.y = player1InfoView.frame.maxY
        player2InfoView.frame.size = CGSize(width: width, height: height)
        
        player3InfoView.frame.origin.y = player2InfoView.frame.maxY
        player3InfoView.frame.size = CGSize(width: width, height: height)
        
        player4InfoView.frame.origin.y = player3InfoView.frame.maxY
        player4InfoView.frame.size = CGSize(width: width, height: height)
    }
    
    @objc func player1InfoViewTapped() {
        if player1InfoView.locked {
            return
        }
        currentRoundWinner = game.player1
        currentRoundFirer = nil
        currentRoundLoserPointInfo = [:]
        player1InfoView.setWinUI()
        player2InfoView.setLoseUI()
        player3InfoView.setLoseUI()
        player4InfoView.setLoseUI()
    }
    
    @objc func player2InfoViewTapped() {
        if player2InfoView.locked {
            return
        }
        currentRoundWinner = game.player2
        currentRoundFirer = nil
        currentRoundLoserPointInfo = [:]
        player2InfoView.setWinUI()
        player1InfoView.setLoseUI()
        player3InfoView.setLoseUI()
        player4InfoView.setLoseUI()
    }
    
    @objc func player3InfoViewTapped() {
        if player3InfoView.locked {
            return
        }
        currentRoundWinner = game.player3
        currentRoundFirer = nil
        currentRoundLoserPointInfo = [:]
        player3InfoView.setWinUI()
        player1InfoView.setLoseUI()
        player2InfoView.setLoseUI()
        player4InfoView.setLoseUI()
    }
    
    @objc func player4InfoViewTapped() {
        if player4InfoView.locked {
            return
        }
        currentRoundWinner = game.player4
        currentRoundFirer = nil
        currentRoundLoserPointInfo = [:]
        player4InfoView.setWinUI()
        player1InfoView.setLoseUI()
        player2InfoView.setLoseUI()
        player3InfoView.setLoseUI()
    }
    
    @objc func endButtonClicked() {
        if locked {
            return
        }
        let ac = UIAlertController(title: "确定结束吗", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "结束", style: .destructive, handler: { action in
            self.endGame()
        }))
        present(ac, animated: true, completion: nil)
    }
    
    func endGame() {
        didFinishHandler?()
        pushResultViewController()
    }
    
    func pushResultViewController() {
        let vc = ResultViewController(game: game)
        navigationController?.pushViewController(vc, animated: true)
    } 
    
    func playerForPlayerInfoView(_ playerInfoView: PlayerInfoView) -> Player? {
        if playerInfoView === player1InfoView {
            return game.player1
        }
        if playerInfoView === player2InfoView {
            return game.player2
        }
        if playerInfoView === player3InfoView {
            return game.player3
        }
        if playerInfoView === player4InfoView {
            return game.player4
        }
        return nil
    }
    
    func updatePlayerData() {
        guard let winner = currentRoundWinner else {
            return
        }
        // update point
        for (player, point) in currentRoundLoserPointInfo {
            player.point -= point
            winner.point += point
        }
        // update win times
        if currentRoundLoserPointInfo.count == 3 {
            winner.winTimes += 1
            winner.continuousWinTimes += 1
            for player in currentRoundLoserPointInfo.keys {
                player.continuousWinTimes = 0
            }
        }
        // update own draw or fire times
        if let firer = currentRoundFirer {
            firer.fireTimes += 1
        } else {
            winner.ownDrawTimes += 1
        }
        // save game data
        Game.saveGame(game)
    }
    
    func updatePlayerInfoViewsData() {
        // update UI for win times
        player1InfoView.winTimes = game.player1.winTimes
        player2InfoView.winTimes = game.player2.winTimes
        player3InfoView.winTimes = game.player3.winTimes
        player4InfoView.winTimes = game.player4.winTimes
        // update UI for continuous win times
        player1InfoView.continuousWinTimes = game.player1.continuousWinTimes
        player2InfoView.continuousWinTimes = game.player2.continuousWinTimes
        player3InfoView.continuousWinTimes = game.player3.continuousWinTimes
        player4InfoView.continuousWinTimes = game.player4.continuousWinTimes
        // update UI for own draw times
        player1InfoView.ownDrawTimes = game.player1.ownDrawTimes
        player2InfoView.ownDrawTimes = game.player2.ownDrawTimes
        player3InfoView.ownDrawTimes = game.player3.ownDrawTimes
        player4InfoView.ownDrawTimes = game.player4.ownDrawTimes
        // update UI for fire times
        player1InfoView.fireTimes = game.player1.fireTimes
        player2InfoView.fireTimes = game.player2.fireTimes
        player3InfoView.fireTimes = game.player3.fireTimes
        player4InfoView.fireTimes = game.player4.fireTimes
        // update UI for point
        player1InfoView.point = game.player1.point
        player2InfoView.point = game.player2.point
        player3InfoView.point = game.player3.point
        player4InfoView.point = game.player4.point
    }
    
    func updatePlayerInfoViewsPointButtonSelection(_ selectedPlayerInfoView: PlayerInfoView?) {
        if selectedPlayerInfoView != player1InfoView {
            player1InfoView.clearPointButtonSelection()
        }
        if selectedPlayerInfoView != player2InfoView {
            player2InfoView.clearPointButtonSelection()
        }
        if selectedPlayerInfoView != player3InfoView {
            player3InfoView.clearPointButtonSelection()
        }
        if selectedPlayerInfoView != player4InfoView {
            player4InfoView.clearPointButtonSelection()
        } 
    }
    
    func updatePlayerInfoViewsOwnDrawButtonSelection(_ selectedPlayerInfoView: PlayerInfoView?) {
        if selectedPlayerInfoView != player1InfoView {
            player1InfoView.clearOwnDrawButtonSelection()
        }
        if selectedPlayerInfoView != player2InfoView {
            player2InfoView.clearOwnDrawButtonSelection()
        }
        if selectedPlayerInfoView != player3InfoView {
            player3InfoView.clearOwnDrawButtonSelection()
        }
        if selectedPlayerInfoView != player4InfoView {
            player4InfoView.clearOwnDrawButtonSelection()
        } 
    }
    
    func updatePlayerInfoViewsFireButtonSelection(_ selectedPlayerInfoView: PlayerInfoView?) {
        if selectedPlayerInfoView != player1InfoView {
            player1InfoView.clearFireButtonSelection()
        }
        if selectedPlayerInfoView != player2InfoView {
            player2InfoView.clearFireButtonSelection()
        }
        if selectedPlayerInfoView != player3InfoView {
            player3InfoView.clearFireButtonSelection()
        }
        if selectedPlayerInfoView != player4InfoView {
            player4InfoView.clearFireButtonSelection()
        } 
    }
    
    func updatePlayerInfoViewsUIStatus() {
        player1InfoView.resetUI()
        player2InfoView.resetUI()
        player3InfoView.resetUI()
        player4InfoView.resetUI()
    }
    
    func checkPointButtonSelection(continueAction: @escaping () -> Void) {
        if currentRoundLoserPointInfo.count < 3 {
            let ac = UIAlertController(title: "还有玩家未选择点数", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "继续", style: .default, handler: { _ in
                continueAction()
            }))
            present(ac, animated: true, completion: nil)
        } else {
            continueAction()
        }
    }
}

extension GameViewController: PlayerInfoViewDelegate {
    
    func playerInfoView(_ playerInfoView: PlayerInfoView, doneButtonDidClick button: UIButton) {
        checkPointButtonSelection {
            self.updatePlayerData()
            self.updatePlayerInfoViewsData()
            self.updatePlayerInfoViewsOwnDrawButtonSelection(nil)
            self.updatePlayerInfoViewsFireButtonSelection(nil)
            self.updatePlayerInfoViewsPointButtonSelection(nil)
            self.updatePlayerInfoViewsUIStatus()
        }
    }
    
    func playerInfoView(_ playerInfoView: PlayerInfoView, cancelButtonDidClick button: UIButton) {
        updatePlayerInfoViewsOwnDrawButtonSelection(nil)
        updatePlayerInfoViewsFireButtonSelection(nil)
        updatePlayerInfoViewsPointButtonSelection(nil)
        updatePlayerInfoViewsUIStatus()
    }
    
    func playerInfoView(_ playerInfoView: PlayerInfoView, pointButtonDidClick button: UIButton) {
        guard let player = playerForPlayerInfoView(playerInfoView) else {
            return
        }
        guard let title = button.title(for: .normal), let point = Int(title) else {
            return
        }
        if button.isSelected {
            currentRoundLoserPointInfo[player] = point
        } else {
            currentRoundLoserPointInfo[player] = nil
        }
    }
    
    func playerInfoView(_ playerInfoView: PlayerInfoView, ownDrawButtonDidClick button: UIButton) {
        updatePlayerInfoViewsOwnDrawButtonSelection(playerInfoView)
        updatePlayerInfoViewsFireButtonSelection(playerInfoView)
        currentRoundFirer = nil
    }
    
    func playerInfoView(_ playerInfoView: PlayerInfoView, fireButtonDidClick button: UIButton) {
        updatePlayerInfoViewsOwnDrawButtonSelection(playerInfoView)
        updatePlayerInfoViewsFireButtonSelection(playerInfoView)
        currentRoundFirer = playerForPlayerInfoView(playerInfoView)
    }
}
