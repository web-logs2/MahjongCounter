//
//  GameViewController.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/24.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    private var player1InfoView: PlayerInfoView!
    private var player2InfoView: PlayerInfoView!
    private var player3InfoView: PlayerInfoView!
    private var player4InfoView: PlayerInfoView!
    private var endButton: UIButton!
    
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
        
        view.backgroundColor = UIColor.white
        
        let player1 = game.player1
        let player2 = game.player2
        let player3 = game.player3
        let player4 = game.player4
        
        let settings = Settings.shared

        player1InfoView = PlayerInfoView(name: player1.name, times: player1.times, point: player1.point)
        player1InfoView.backgroundColor = settings.player1Color
        player1InfoView.addTapGestureRecognizer(target: self, action: #selector(player1InfoViewTapped))
        player1InfoView.delegate = self
        view.addSubview(player1InfoView)
        
        player2InfoView = PlayerInfoView(name: player2.name, times: player2.times, point: player2.point)
        player2InfoView.backgroundColor = settings.player2Color
        player2InfoView.addTapGestureRecognizer(target: self, action: #selector(player2InfoViewTapped))
        player2InfoView.delegate = self
        view.addSubview(player2InfoView)
        
        player3InfoView = PlayerInfoView(name: player3.name, times: player3.times, point: player3.point)
        player3InfoView.backgroundColor = settings.player3Color
        player3InfoView.addTapGestureRecognizer(target: self, action: #selector(player3InfoViewTapped))
        player3InfoView.delegate = self
        view.addSubview(player3InfoView)
        
        player4InfoView = PlayerInfoView(name: player4.name, times: player4.times, point: player4.point)
        player4InfoView.backgroundColor = settings.player4Color
        player4InfoView.addTapGestureRecognizer(target: self, action: #selector(player4InfoViewTapped))
        player4InfoView.delegate = self
        view.addSubview(player4InfoView)
        
        endButton = UIButton()
        endButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        endButton.setBackgroundImage(UIImage(color: .systemBlue), for: .normal)
        endButton.setTitleColor(.white, for: .normal)
        endButton.setTitle("结束", for: .normal)
        endButton.addTarget(self, action: #selector(endButtonClicked), for: .touchUpInside)
        view.addSubview(endButton)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        endButton.frame.size.width = view.frame.width - view.safeAreaInsets.left - view.safeAreaInsets.right
        endButton.frame.size.height = view.safeAreaInsets.bottom + 50
        endButton.frame.origin.x = view.safeAreaInsets.left
        endButton.frame.origin.y = view.frame.height - endButton.frame.height
        endButton.titleEdgeInsets.bottom = view.safeAreaInsets.bottom / 2
        
        let width = endButton.frame.width / 2
        let height = (view.frame.height - view.safeAreaInsets.top - endButton.frame.height) / 2
        
        player1InfoView.frame.origin.x = view.safeAreaInsets.left
        player1InfoView.frame.origin.y = view.safeAreaInsets.top
        player1InfoView.frame.size = CGSize(width: width, height: height)
        
        player2InfoView.frame.origin.x = player1InfoView.frame.maxX
        player2InfoView.frame.origin.y = player1InfoView.frame.minY
        player2InfoView.frame.size = CGSize(width: width, height: height)
        
        player3InfoView.frame.origin.x = player1InfoView.frame.minX
        player3InfoView.frame.origin.y = player1InfoView.frame.maxY
        player3InfoView.frame.size = CGSize(width: width, height: height)
        
        player4InfoView.frame.origin.x = player1InfoView.frame.maxX
        player4InfoView.frame.origin.y = player1InfoView.frame.maxY
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
            self.presentResultViewController()
        }))
        present(ac, animated: true, completion: nil)
    }
    
    func presentResultViewController() {
        let vc = ResultViewController(game: game)
        vc.didFinishHandler = didFinishHandler
        present(vc, animated: true, completion: nil)
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
        // update point for player
        for (player, point) in currentRoundLoserPointInfo {
            player.point -= point
            winner.point += point
        }
        // update times and continuous for player
        if currentRoundLoserPointInfo.count == 3 {
            winner.times += 1
            winner.continuous += 1
            for player in currentRoundLoserPointInfo.keys {
                player.continuous = 0
            }
        }
        // update fires for player
        currentRoundFirer?.fires += 1
        // save game data
        Game.saveGame(game)
    }
    
    func updatePlayerInfoViewsData() {
        // update UI for times
        player1InfoView.updateTimes(game.player1.times, game.player1.continuous)
        player2InfoView.updateTimes(game.player2.times, game.player2.continuous)
        player3InfoView.updateTimes(game.player3.times, game.player3.continuous)
        player4InfoView.updateTimes(game.player4.times, game.player4.continuous)
        // update UI for point
        player1InfoView.updatePoint(game.player1.point)
        player2InfoView.updatePoint(game.player2.point)
        player3InfoView.updatePoint(game.player3.point)
        player4InfoView.updatePoint(game.player4.point)
    }
    
    func updatePlayerInfoViewsPointButtonSelection(_ selectedPlayerInfoView: PlayerInfoView) {
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
    
    func updatePlayerInfoViewsFireButtonSelection(_ selectedPlayerInfoView: PlayerInfoView) {
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
            self.updatePlayerInfoViewsPointButtonSelection(playerInfoView)
            self.updatePlayerInfoViewsUIStatus()
        }
    }
    
    func playerInfoView(_ playerInfoView: PlayerInfoView, cancelButtonDidClick button: UIButton) {
        updatePlayerInfoViewsPointButtonSelection(playerInfoView)
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
    
    func playerInfoView(_ playerInfoView: PlayerInfoView, fireButtonDidClick button: UIButton) {
        updatePlayerInfoViewsFireButtonSelection(playerInfoView)
        currentRoundFirer = playerForPlayerInfoView(playerInfoView)
    }
}
