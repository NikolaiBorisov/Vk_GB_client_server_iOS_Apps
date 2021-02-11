//
//  LikeControl.swift
//  Vk black&white
//
//  Created by Macbook on 22.12.2020.
//

import UIKit

class LikeControl: UIControl {
    var imageView = UIImageView()
    var likeCounterLabel = UILabel()
    
    var likeCounter = 0
    var isLiked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    func setLike(count: Int) {
        likeCounter = count
        setLikeCounterLable()
    }
    
    func setView() {
        self.addSubview(imageView)
        self.addTarget(self, action: #selector(tapControl), for: .touchUpInside)
        
        imageView.tintColor = .systemRed
        imageView.image = UIImage(systemName: "heart")
        setLikeCounterLable()
    }
    
    func setLikeCounterLable() {
        addSubview(likeCounterLabel)
        UIView.transition(with: likeCounterLabel, duration: 0.3, options: .transitionFlipFromTop, animations: {self.likeCounterLabel.text = String(self.likeCounter)
        })
        likeCounterLabel.textColor = .systemRed
        likeCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        likeCounterLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8).isActive = true
        likeCounterLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }
    
    @objc func tapControl() {
        isLiked.toggle()
        if isLiked {
            imageView.image  = UIImage(systemName: "heart.fill")
            likeCounter += 1
            setLikeCounterLable()
        }
    }
}
