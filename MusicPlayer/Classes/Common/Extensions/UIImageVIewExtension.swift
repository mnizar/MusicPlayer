//
//  UIImageVIewExtension.swift
//  MusicPlayer
//
//  Created by Muhammad Nizar on 29/05/21.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func setImage(_ url: String, placeholder: String? = "placeholderImage") {
        self.kf.setImage(with: URL(string: url), placeholder: UIImage(named: placeholder!))
    }
}
