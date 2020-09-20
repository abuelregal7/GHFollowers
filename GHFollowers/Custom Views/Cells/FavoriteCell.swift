//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Ahmed on 8/2/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID  = "FavoriteCell"
    
    let avatarImageView = GFAvatarImageView(cornerRadius: 10)
    let usernameLable   = GFTitleLable(textAlignment: .left, fontZize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower) {
        
        usernameLable.text  = favorite.login
        avatarImageView.downloadImage(from: favorite.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLable)
        
        accessoryType         = .disclosureIndicator
        let padding: CGFloat  = 12
        
        NSLayoutConstraint.activate([
            
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLable.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            usernameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLable.heightAnchor.constraint(equalToConstant: 40)
            
            
            
        ])
        
        
    }
}
