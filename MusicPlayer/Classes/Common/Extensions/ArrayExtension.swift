//
//  ArrayExtension.swift
//  MusicPlayer
//
//  Created by Muhammad Nizar on 30/05/21.
//

import Foundation

extension Array {
    
    func item(at index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
