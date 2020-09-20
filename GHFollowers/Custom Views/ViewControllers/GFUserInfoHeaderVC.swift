//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Ahmed on 8/1/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {

    let avatarImageView   = GFAvatarImageView(frame: .zero)
    let usernameLable     = GFTitleLable(textAlignment: .left, fontZize: 34)
    let nameLable         = GFSecondaryTitleLable(fontSize: 18, fontWeight: .medium)
    let locationImageView = UIImageView()
    let locationLable     = GFSecondaryTitleLable(fontSize: 18, fontWeight: .medium)
    let bioLable          = GFBodyLable(textAlignment: .left)
    
    var user: User!
    
    init(user: User) {
        
        super.init(nibName: nil, bundle: nil)
        self.user = user
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addSubViews()
        layOutUI()
        configureUIElements()
        avatarImageView.layer.cornerRadius = 45
        
    }
    
    func configureUIElements() {
        
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLable.text          = user.login
        nameLable.text              = user.name ?? ""
        locationLable.text          = user.location ?? "No Location"
        bioLable.text               = user.bio ?? "No Bio Available"
        bioLable.numberOfLines      = 3
        locationImageView.image     = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
    
    }
    
    func addSubViews() {
        
        view.addSubview(avatarImageView)
        view.addSubview(usernameLable)
        view.addSubview(nameLable)
        view.addSubview(locationImageView)
        view.addSubview(locationLable)
        view.addSubview(bioLable)
        
    }
    
    func layOutUI() {
        
        let padding: CGFloat          = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            usernameLable.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLable.heightAnchor.constraint(equalToConstant: 38),
            
            nameLable.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLable.heightAnchor.constraint(equalToConstant: 22),
//            nameLable.topAnchor.constraint(equalTo: usernameLable.bottomAnchor, constant: padding),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            
            locationLable.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLable.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLable.heightAnchor.constraint(equalToConstant: 20),
            
            bioLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            //bioLable.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLable.heightAnchor.constraint(equalToConstant: 60),
            
            

            
            
            
        ])
        
    }
    
}
