//
//  HomeViewController.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/24.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Games"
        navigationItem.rightBarButtonItem = UIBarButtonItem.add(target: self, action: #selector(addButtonClick))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkUnfinishedGame()
    }
    
    @objc func addButtonClick() {
        startGame()
    }
    
    func checkUnfinishedGame() {
        if Game.hasCheckedUnfinishedGame {
            return
        }
        Game.hasCheckedUnfinishedGame = true
        
        if let game = Game.loadUnfinishedGame() {
            let ac = UIAlertController(title: "检测到有未结束的局", message: "是否继续", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "取消", style: .destructive, handler: nil))
            ac.addAction(UIAlertAction(title: "继续", style: .default, handler: { action in
                Game.current = game
                self.startGame()
            }))
            present(ac, animated: true, completion: nil)
        }
    }
    
    func startGame() {
        if let game = Game.current {
            pushGameViewController(game: game)
        } else {
            let game = createNewGame()
            pushGameViewController(game: game)
        }
    }
    
    func createNewGame() -> Game {
        let game = Game()
        Game.current = game
        return game
    }
    
    func pushGameViewController(game: Game) {
        let vc = GameViewController(game: game)
        vc.didFinishHandler = {
            Game.current = nil
            Game.clearSavedGame()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
