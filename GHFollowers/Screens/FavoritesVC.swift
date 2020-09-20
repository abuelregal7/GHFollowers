//
//  FavoritesVC.swift
//  GHFollowers
//
//  Created by Ahmed on 6/22/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

    let remove = true
    let tableView              = UITableView()
    var favorites: [Follower]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViewController()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewController() {
        
        view.backgroundColor = .systemBackground
        title                = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func configureTableView() {
        
        view.addSubview(tableView)
        tableView.frame        = view.bounds
        tableView.rowHeight    = 80
        tableView.delegate     = self
        tableView.dataSource   = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        
    }
    
    func getFavorites() {
        
        PersistenceManager.retrieveFavorites { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let favorites):
                print(favorites)
                
                if favorites.isEmpty {
                    let message = "No favorite?\nAdd one on the follower screen. 😀"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                }
                } else{
                    
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Somthing went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
        
    }
    
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let favorite      = favorites[indexPath.row]
//        let desVC         = FollowerListVC()
        let desVC         = FollowerListVC(username: favorite.login)
//        desVC.username    = favorite.login
//        desVC.title       = favorite.login
        navigationController?.pushViewController(desVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        if remove {
            
            PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
                
                guard let self = self else { return }
                
                guard let error = error else { return }
                
                self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
                
            }
            self.presentGFAlertOnMainThread(title: "seccess", message: "User is removed", buttonTitle: "OK")
        }else {
            self.presentGFAlertOnMainThread(title: "Somthing went wrong", message: "User not remove", buttonTitle: "Ok")
        }
        
    }
}
