//
//  GFSecondaryTitleLable.swift
//  GHFollowers
//
//  Created by Ahmed on 8/1/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class GFSecondaryTitleLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(/*textAlignment: NSTextAlignment, fontZize: CGFloat,*/fontSize: CGFloat, fontWeight: UIFont.Weight){
        super.init(frame: .zero)
        //self.textAlignment = textAlignment
        self.font          = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        //self.font = UIFont.systemFont(ofSize: fontZize, weight: .bold)
        configure()
    }
    
    private func configure() {
        
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
