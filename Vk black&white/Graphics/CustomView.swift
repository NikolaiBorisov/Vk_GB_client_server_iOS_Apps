//
//  TestView.swift
//  Vk black&white
//
//  Created by Macbook on 12.12.2020.
//

import UIKit

class RoundingAvatar: UIImageView {
    
override func layoutSubviews() {
    super.layoutSubviews()
    
    layer.cornerRadius = bounds.height / 2
    layer.borderWidth = 3
    layer.borderColor = UIColor.darkGray.cgColor
    clipsToBounds = true
    }
}

class Shadow: UIImageView {
    
override func layoutSubviews() {
    super.layoutSubviews()
    
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 4.0
    layer.shadowRadius = 10
    
//    layer.borderColor = UIColor.darkGray.cgColor
//    layer.borderWidth = 2
    
    layer.cornerRadius = bounds.height / 2
    
    clipsToBounds = false
    
//    let translation3D = CATransform3DMakeTranslation(-10, 10, 100)
//    layer.transform = translation3D
    }
}

class RoundingPictures: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.borderWidth = 3
        layer.borderColor = UIColor.darkGray.cgColor
    }
}
