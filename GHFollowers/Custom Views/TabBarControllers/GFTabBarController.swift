//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Ahmed on 8/2/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = UIColor.systemGreen
        viewControllers                 = [createSearchNavigationController(), createFavoritesNavigationController()]
    }
    
    // MARK: createSearchNC
       func createSearchNavigationController() -> UINavigationController{
           
           let searchVC = SearchVC()
           searchVC.title = "Search"
           searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
           return UINavigationController(rootViewController: searchVC)
           
       }
       // MARK: createFavoritesNC
       func createFavoritesNavigationController() -> UINavigationController{
           
           let favoritesVC = FavoritesVC()
           favoritesVC.title = "Favorites"
           favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
           return UINavigationController(rootViewController: favoritesVC)
           
       }

}
