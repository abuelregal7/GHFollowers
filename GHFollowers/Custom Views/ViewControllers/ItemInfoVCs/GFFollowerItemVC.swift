//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Ahmed on 8/1/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewtwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
        
    }
    override func actionbuttonTapped() {
        delegate.didTapGitFollowers(for: user)
    }
    
}
