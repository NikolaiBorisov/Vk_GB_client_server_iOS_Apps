//
//  PicturesCell.swift
//  Vk black&white
//
//  Created by Macbook on 08.12.2020.
//

import UIKit

class FriendsPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var pictures: UIImageView!
    @IBOutlet weak var likeControl: LikeControl!
    
    static let reuseID = "PicturesCell"
    var user: User?
    
    func configure(with imageUrl: String) {
        let url = URL(string: imageUrl)
        self.pictures.kf.setImage(with: url)
    }
    
}
