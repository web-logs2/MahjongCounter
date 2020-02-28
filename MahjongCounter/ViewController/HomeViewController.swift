//
//  HomeViewController.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/24.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var startButton: UIButton!
    private var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        startButton = UIButton()
        startButton.layer.cornerRadius = 8
        startButton.layer.masksToBounds = true
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        startButton.setBackgroundImage(UIImage(color: .orange), for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitle("开始", for: .normal)
        startButton.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)
        view.addSubview(startButton)
        
        /*
        settingsButton = UIButton()
        settingsButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        startButton.setBackgroundImage(UIImage(color: .gray), for: .normal)
        settingsButton.setTitleColor(.white, for: .normal)
        settingsButton.setTitle("设置", for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonClick), for: .touchUpInside)
        view.addSubview(settingsButton)
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkUnfinishedGame()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        startButton.frame.origin.x = 50
        startButton.frame.size.width = view.frame.width - startButton.frame.minX * 2
        startButton.frame.size.height = 100
        startButton.frame.origin.y = (view.frame.height - startButton.frame.height) / 2
        
        /*
        settingsButton.frame.origin = CGPoint(x: startButton.frame.minX, y: startButton.frame.maxY + 30)
        settingsButton.frame.size = CGSize(width: startButton.frame.width, height: 50)
        */
    }
    
    @objc func startButtonClick() {
        startGame()
    }
    
    @objc func settingsButtonClick() {
        
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
            presentGameViewController(game: game)
        } else {
            let game = createNewGame()
            presentGameViewController(game: game)
        }
    }
    
    func createNewGame() -> Game {
        let game = Game()
        Game.current = game
        return game
    }
    
    func presentGameViewController(game: Game) {
        let vc = GameViewController(game: game)
        vc.didFinishHandler = {
            Game.current = nil
            Game.clearSavedGame()
            self.dismiss(animated: true, completion: nil)
        }
        present(vc, animated: true, completion: nil)
    }
}
