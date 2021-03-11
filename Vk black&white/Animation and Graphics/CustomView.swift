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
        layer.shadowOffset = CGSize(width: -5, height: -5)
        
        layer.cornerRadius = bounds.height / 2
        
        clipsToBounds = false
    }
}

class ShadowForCellphoneStatus: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOpacity = 50
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = bounds.height / 2
        self.clipsToBounds = false
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
