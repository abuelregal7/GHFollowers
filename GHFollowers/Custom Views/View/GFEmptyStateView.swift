//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Ahmed on 7/27/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLable = GFTitleLable(textAlignment: .center, fontZize: 28)
    let logoImageView = UIImageView()
    
    //var message: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        
        super.init(frame: .zero)
        
        //self.message = message
        messageLable.text = message
        configure()
        
    }
    
    private func configure() {
        
        addSubview(messageLable)
        addSubview(logoImageView)
        
        //messageLable.text            = message ?? "Something went wrong"
        messageLable.numberOfLines   = 3
        messageLable.textColor       = .secondaryLabel
        
        logoImageView.image          = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            messageLable.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLable.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        
        ])
        
    }
    
}
