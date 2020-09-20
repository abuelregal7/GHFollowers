//
//  Design.swift
//  GHFollowers
//
//  Created by Ahmed on 8/1/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    func roundImage()
    {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderColor = UIColor.clear.cgColor
        //self.layer.borderColor = UIColor().colo
        self.layer.borderWidth = 6
        self.clipsToBounds = true
        
    }
    
}


extension UIButton
{
    func roundButton()
    {
        //self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor().colorFromHex("CCFF33").cgColor
        self.layer.borderWidth = 3
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
extension UITextField
{
    func roundTextField()
    {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderColor = UIColor().colorFromHex("90FEFB").cgColor
        self.layer.borderWidth = 2
        self.clipsToBounds = true
    }
}
extension UILabel
{
    func roundLable()
    {
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor.yellow.cgColor
        self.layer.borderWidth = 4
        self.clipsToBounds = true
    }
}
extension UIColor
{
    func colorFromHex(_ hex : String) -> UIColor
    {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#"){
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6{
            return UIColor.black
        }
        var rgb : UInt32 = 0
        Scanner(string : hexString).scanHexInt32(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((rgb & 0x00FF00) >> 8 ) / 255.0,
                            blue: CGFloat((rgb & 0x0000FF)) / 255.0,
                            alpha: 1.0)
    }
}
