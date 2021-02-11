//
//  PicturesCell.swift
//  Vk black&white
//
//  Created by Macbook on 08.12.2020.
//

import UIKit

class PicturesCell: UICollectionViewCell {
    
    static let reuseID = "PicturesCell"
    
    @IBAction func pulseButton(_ sender: UIButton) {
        sender.pulsate()
    }
    
    @IBOutlet weak var pictures: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCounter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.borderWidth = 3
        layer.borderColor = UIColor.darkGray.cgColor
//Без тени для фото
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 1
//        layer.shadowRadius = 2
        likeButton.setImage(#imageLiteral(resourceName: "11_119290_heart_romance_valentines_day_download_red_heart_clipart"), for: .selected)
        likeButton.setImage(#imageLiteral(resourceName: "2e72b56197ecc776518d48477fd8e494"), for: .normal)
        
    }
    
    @IBAction func like(_ sender: UIButton) {
        likeButton.isSelected.toggle()
        likesCounter.textColor = likeButton.isSelected ? .red : .lightGray
        likesCounter.text = likeButton.isSelected ? "1" : "0"
        UIView.animateKeyframes(withDuration: 0.2, delay: 0.2, options: .autoreverse, animations: { self.likesCounter.frame.origin.y += 10 })
        self.likesCounter.frame.origin.y -= 10
        
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
// Без анимации счетчика лайков
//        likeButton.isSelected.toggle()
//        likesCounter.textColor = likeButton.isSelected ? .red : .systemGray
//        likesCounter.text = likeButton.isSelected ? "1" : "0"
//        if likeButton.isSelected {
//        }
//    }
}
