//
//  AllFriendsCell.swift
//  Vk black&white
//
//  Created by Macbook on 08.12.2020.
//

import UIKit
import Kingfisher

class MyFriendsCell: UITableViewCell {
    
    
    @IBOutlet weak var friendsName: UILabel!
    @IBOutlet weak var friendsPhoto: UIImageView!
    @IBOutlet weak var friendsStatus: UILabel!
    
    @IBOutlet weak var shadowView: Shadow!
    @IBAction func animateAvatar(_ sender: UIImageView) {
        shadowView.animateAvatar()
    }
    
    //Метод подготавливает переиспользуемую ячейку для повторного использования делегатом тейбл вью
    override func prepareForReuse() {
        super.prepareForReuse()
        self.friendsName.text = nil
        self.friendsPhoto.image = nil
    }
    
    //Метод конфигурации данных ячейки
    func configure(with user: User) {
        self.friendsName.text = "\(user.firstName) \(user.lastName)"
        self.friendsStatus.textColor = .lightGray
        let url = URL(string: user.photo100)
        self.friendsPhoto.kf.setImage(with: url)
    }

}



