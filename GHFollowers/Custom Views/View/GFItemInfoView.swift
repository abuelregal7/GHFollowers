//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Ahmed on 8/1/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {

    let symboleImageView = UIImageView()
    let titleLable       = GFTitleLable(textAlignment: .left, fontZize: 14)
    let countLable       = GFTitleLable(textAlignment: .center, fontZize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        addSubview(symboleImageView)
        addSubview(titleLable)
        addSubview(countLable)
        
        symboleImageView.translatesAutoresizingMaskIntoConstraints = false
        symboleImageView.contentMode = .scaleAspectFill
        symboleImageView.tintColor   = .label
        
        NSLayoutConstraint.activate([
        
            symboleImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symboleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symboleImageView.widthAnchor.constraint(equalToConstant: 20),
            symboleImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLable.centerYAnchor.constraint(equalTo: symboleImageView.centerYAnchor),
            titleLable.leadingAnchor.constraint(equalTo: symboleImageView.trailingAnchor, constant: 12),
            titleLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLable.heightAnchor.constraint(equalToConstant: 18),
            
            countLable.topAnchor.constraint(equalTo: symboleImageView.bottomAnchor, constant: 4),
            countLable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLable.heightAnchor.constraint(equalToConstant: 18)
        
        ])
        
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        
        switch itemInfoType {
            
        case .repos:
            symboleImageView.image = UIImage(systemName: SFSymbols.repose)
            titleLable.text        = "Public Repos"
        case.gists:
            symboleImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLable.text        = "Public Gists"
        case .followers:
            symboleImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLable.text        = "Followers"
        case .following:
            symboleImageView.image = UIImage(systemName: SFSymbols.following)
            titleLable.text        = "Following"
        
        }
        
        countLable.text            = String(count)
    }
    
}
