//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Ahmed on 7/17/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID  = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLable   = GFTitleLable(textAlignment: .center, fontZize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        
        usernameLable.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
        
    }
    
    private func configure() {
        
        let padding: CGFloat = 8
        
        addSubview(avatarImageView)
        addSubview(usernameLable)
        
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            usernameLable.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }
    
}
