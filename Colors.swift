//
//  Colors.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/9/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

enum Colors {
    case primaryGColor1
    case primaryGColor2
    case primaryGColor3
    case iconTintColorSelected
    case iconTintColorUnselected
    case iconBGColorSelected
    case iconBGColorUnselected
    
    func getColors() -> String {
        switch self {
        case .primaryGColor1:
            return "#FE936D"
        case .primaryGColor2:
            return "#FE6765"
        case .primaryGColor3:
            return "#FF2F5B"
        case .iconTintColorSelected:
            return "#FF2F5B"
        case .iconBGColorSelected:
            return "#FF2F5B"
        case .iconTintColorUnselected:
            return "#C5CBD8"
        case .iconBGColorUnselected:
            return "#F7F7F7"
        }
    }
}
