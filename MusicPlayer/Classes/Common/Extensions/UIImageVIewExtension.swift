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
    
    func animatedImages(for name: String) -> [UIImage] {
        
        var i = 0
        var images = [UIImage]()
        
        while let image = UIImage(named: "\(name)/\(i)") {
            images.append(image)
            i += 1
        }
        return images
    }
    
    func startAnimatedImages(imageName:String) {
        self.animationImages = animatedImages(for: imageName)
        self.animationDuration = 1
        self.animationRepeatCount = 0
        self.image = self.animationImages?.first
        self.startAnimating()
    }
}
