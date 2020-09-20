//
//  SFSymbols.swift
//  GHFollowers
//
//  Created by Ahmed on 8/1/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit
enum SFSymbols {
    static let location     = "mappin.and.ellipse"
    static let repose       = "folder"
    static let gists        = "text.alignleft"
    static let followers    = "heart"
    static let following    = "person.2"
}

enum Images {
    static let ghLogo = UIImage(named: "gh-logo")
}

enum ScreenSize {
    
    static let width       = UIScreen.main.bounds.size.width
    static let height      = UIScreen.main.bounds.size.height
    static let maxlength   = max(ScreenSize.width, ScreenSize.height)
    static let minlength   = min(ScreenSize.width, ScreenSize.height)
    
}
enum DeviceTypes {
    
    static let idiom                  = UIDevice.current.userInterfaceIdiom
    static let nativeScale            = UIScreen.main.nativeScale
    static let scale                  = UIScreen.main.scale
    
    
    static let isiphoneSE             = idiom == .phone && ScreenSize.maxlength == 568.0
    static let isiphone8Standard      = idiom == .phone && ScreenSize.maxlength == 667.0 && nativeScale == scale
    static let isiphone8Zoomed        = idiom == .phone && ScreenSize.maxlength == 667.0 && nativeScale > scale
    static let isiphone8plusStandard  = idiom == .phone && ScreenSize.maxlength == 736.0
    static let isiphone8PlusZoomed    = idiom == .phone && ScreenSize.maxlength == 736.0 && nativeScale < scale
    static let isiphoneX              = idiom == .phone && ScreenSize.maxlength == 812.0
    static let isiphoneXsMaxAndXr     = idiom == .phone && ScreenSize.maxlength == 896.0
    static let isipad                 = idiom == .pad && ScreenSize.maxlength   >= 1024.0
    
    static func isiphoneXAspectRatio() -> Bool {
        
        return isiphoneX || isiphoneXsMaxAndXr
        
    }
}
