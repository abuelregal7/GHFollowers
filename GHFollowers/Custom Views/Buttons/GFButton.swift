//
//  GFButton.swift
//  GHFollowers
//
//  Created by Ahmed on 6/23/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String, cornerRadius: CGFloat){
        super.init(frame: .zero)
        self.backgroundColor                      = backgroundColor
        self.layer.cornerRadius                   = CGFloat(cornerRadius)
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){
        //layer.cornerRadius                        = 10
        //titleLabel?.textColor                     = .white
        setTitleColor(.white, for: .normal)
        titleLabel?.font                          = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
