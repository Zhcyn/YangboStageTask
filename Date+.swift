//
//  Date+.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/12/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

extension Date {
    func convertTimeFormate() -> String {
        // Formate
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let newTime = formatter.string(from: self)
        
        return newTime
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM yyyy"
        return dateFormatter.string(from: self).capitalized
    }
}
