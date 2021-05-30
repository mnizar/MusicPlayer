//
//  Constants.swift
//  MusicPlayer
//
//  Created by Muhammad Nizar on 29/05/21.
//

import UIKit

struct Constants {
    
    enum Colors: String {
        case C4C4C4 = "#c4c4c4"              // 218 218 218
        case F3F3F3 = "#f3f3f3"
        
        func color() -> UIColor {
            return UIColor(hex: self.rawValue)
        }
    }
}
