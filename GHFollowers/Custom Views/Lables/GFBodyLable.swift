//
//  GFBodyLable.swift
//  GHFollowers
//
//  Created by Ahmed on 7/6/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class GFBodyLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment/*, fontZize: CGFloat*/){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        //self.font = UIFont.systemFont(ofSize: fontZize, weight: .bold)
        configure()
    }
    
    private func configure() {
        
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        
    }


}
