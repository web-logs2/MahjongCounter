//
//  HomeViewController.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/24.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private var tableView: UITableView!
    
    private var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "全部牌局"
        navigationItem.rightBarButtonItem = UIBarButtonItem.add(target: self, action: #selector(addButtonClick))
        
        tableView = UITableView()
        tableView.register(GameTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        view = tableView
        
        GameStore.addObserver(self)
        GameStore.loadGamesFromLocal()
    }
    
    @objc func addButtonClick() {
        createNewGameIfNeeded()
    }
    
    func createNewGameIfNeeded() {
        if let game = games.first, game.isPlaying {
            showUnfinishedGameAlert()
        } else {
            let game = Game()
            GameStore.addGame(game)
            pushGameViewController(game: game)
        }
    }
    
    func showUnfinishedGameAlert() {
        let ac = UIAlertController(title: "创建失败", message: "当前还有未完成的牌局", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "知道了", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func pushGameViewController(game: Game) {
        let vc = GameViewController(game: game)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushResultViewController(game: Game) {
        let vc = ResultViewController(game: game)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteGame(_ game: Game) {
        GameStore.deleteGame(game)
    }
}

extension HomeViewController: GameStoreObservering {
    
    func gamesDidUpdate(_ games: [Game]) {
        self.games = games
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTableViewCell
        
        let game = games[indexPath.row]
        cell.createDate = game.createDate
        cell.isPlaying = game.isPlaying
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let game = games[indexPath.row]
        if game.isPlaying {
            pushGameViewController(game: game)
        } else {
            pushResultViewController(game: game)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let game = games[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { (_, _, completionHandler) in
            self.deleteGame(game)
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
