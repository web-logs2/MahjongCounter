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
    private var currentRound: Round?
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
        let round = Round()
        round.winner = game.player1
        currentRound = round
        player1InfoView.setWinUI()
        player2InfoView.setLoseUI()
        player3InfoView.setLoseUI()
        player4InfoView.setLoseUI()
    }
    
    @objc func player2InfoViewTapped() {
        if player2InfoView.locked {
            return
        }
        let round = Round()
        round.winner = game.player2
        currentRound = round
        player2InfoView.setWinUI()
        player1InfoView.setLoseUI()
        player3InfoView.setLoseUI()
        player4InfoView.setLoseUI()
    }
    
    @objc func player3InfoViewTapped() {
        if player3InfoView.locked {
            return
        }
        let round = Round()
        round.winner = game.player3
        currentRound = round
        player3InfoView.setWinUI()
        player1InfoView.setLoseUI()
        player2InfoView.setLoseUI()
        player4InfoView.setLoseUI()
    }
    
    @objc func player4InfoViewTapped() {
        if player4InfoView.locked {
            return
        }
        let round = Round()
        round.winner = game.player4
        currentRound = round
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
        game.isPlaying = false
        GameStore.updateGame(game)
        pushResultViewController()
    }
    
    func pushResultViewController() {
        let vc = ResultViewController(game: game)
        vc.useCustomBackButton = true
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
    
    func updatePlayerData(round: Round) {
        guard let winner = round.winner else { return }
        // update point
        for (player, point) in round.loserPointInfo {
            player.point -= point
            winner.point += point
        }
        // update win times
        winner.winTimes += 1
        // update own draw or fire times
        if let firer = round.firer {
            firer.fireTimes += 1
        } else {
            winner.ownDrawTimes += 1
        }
        // update rounds
        game.rounds.insert(round, at: 0)
        // save game data
        GameStore.updateGame(game)
    }
    
    func revertPlayerData(round: Round) {
        guard let winner = round.winner else { return }
        // update point
        for (player, point) in round.loserPointInfo {
            player.point += point
            winner.point -= point
        }
        // update win times
        winner.winTimes -= 1
        // update own draw or fire times
        if let firer = round.firer {
            firer.fireTimes -= 1
        } else {
            winner.ownDrawTimes -= 1
        }
        // update rounds
        game.rounds.remove(at: 0)
        // save game data
        GameStore.updateGame(game)
    }
    
    func updatePlayerInfoViewsData() {
        // update UI for win times
        player1InfoView.winTimes = game.player1.winTimes
        player2InfoView.winTimes = game.player2.winTimes
        player3InfoView.winTimes = game.player3.winTimes
        player4InfoView.winTimes = game.player4.winTimes
        // update UI for continuous win times
        let continuousWinTimes = calculateContinuousWinTimes()
        player1InfoView.continuousWinTimes = continuousWinTimes[0]
        player2InfoView.continuousWinTimes = continuousWinTimes[1]
        player3InfoView.continuousWinTimes = continuousWinTimes[2]
        player4InfoView.continuousWinTimes = continuousWinTimes[3]
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
    
    func calculateContinuousWinTimes() -> [Int] {
        var times: [Int] = Array<Int>(repeating: 0, count: 4)
        guard let winner = game.rounds.first?.winner else { return times }
        let players: [Player] = [game.player1, game.player2, game.player3, game.player4]
        guard let index = players.firstIndex(of: winner) else { return times }
        for round in game.rounds {
            if round.winner == winner {
                times[index] += 1
            } else {
                break
            }
        }
        return times
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
}

extension GameViewController: PlayerInfoViewDelegate {
    
    func playerInfoView(_ playerInfoView: PlayerInfoView, doneButtonDidClick button: UIButton) {
        guard let round = currentRound else { return }
        // check point update
        if round.loserPointInfo.count < 3 {
            let ac = UIAlertController(title: "还有玩家未选择点数", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "知道了", style: .cancel, handler: nil))
            present(ac, animated: true, completion: nil)
            return
        }
        updatePlayerData(round: round)
        updatePlayerInfoViewsData()
        updatePlayerInfoViewsOwnDrawButtonSelection(nil)
        updatePlayerInfoViewsFireButtonSelection(nil)
        updatePlayerInfoViewsPointButtonSelection(nil)
        updatePlayerInfoViewsUIStatus()
    }
    
    func playerInfoView(_ playerInfoView: PlayerInfoView, cancelButtonDidClick button: UIButton) {
        updatePlayerInfoViewsOwnDrawButtonSelection(nil)
        updatePlayerInfoViewsFireButtonSelection(nil)
        updatePlayerInfoViewsPointButtonSelection(nil)
        updatePlayerInfoViewsUIStatus()
    }
    
    func playerInfoView(_ playerInfoView: PlayerInfoView, pointButtonDidClick button: UIButton) {
        guard let round = currentRound else { return }
        guard let player = playerForPlayerInfoView(playerInfoView) else { return }
        guard let title = button.title(for: .normal), let point = Int(title) else { return }
        if button.isSelected {
            round.loserPointInfo[player] = point
        } else {
            round.loserPointInfo[player] = nil
        }
    }
    
    func playerInfoView(_ playerInfoView: PlayerInfoView, ownDrawButtonDidClick button: UIButton) {
        guard let round = currentRound else { return }
        updatePlayerInfoViewsOwnDrawButtonSelection(playerInfoView)
        updatePlayerInfoViewsFireButtonSelection(playerInfoView)
        round.firer = nil
    }
    
    func playerInfoView(_ playerInfoView: PlayerInfoView, fireButtonDidClick button: UIButton) {
        guard let round = currentRound else { return }
        updatePlayerInfoViewsOwnDrawButtonSelection(playerInfoView)
        updatePlayerInfoViewsFireButtonSelection(playerInfoView)
        round.firer = playerForPlayerInfoView(playerInfoView)
    }
}

extension GameViewController {
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        if let round = game.rounds.first {
            let ac = UIAlertController(title: "是否撤销上次操作", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "撤销", style: .destructive, handler: { _ in
                self.revertPlayerData(round: round)
                self.updatePlayerInfoViewsData()
            }))
            present(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "暂无需要撤销的操作", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "知道了", style: .cancel, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
}
