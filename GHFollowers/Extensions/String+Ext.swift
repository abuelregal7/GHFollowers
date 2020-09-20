//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Ahmed on 8/1/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation

extension String {
    
    func conveertToDate() -> Date? {
        
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone      = .current
        
        return dateFormatter.date(from: self)
        
    }
    
    func convertToDisplayformat() -> String {
        
        guard let date = self.conveertToDate() else { return "N/A" }
        
        return date.convertToMonthYearFormat()
    }
    
}
