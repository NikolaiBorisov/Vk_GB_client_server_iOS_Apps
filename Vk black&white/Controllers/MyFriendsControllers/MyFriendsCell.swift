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
    @IBOutlet weak var statusOnline: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var chatButton: UIButton!
    
    @IBOutlet weak var shadowView: Shadow!
    @IBAction func animateAvatar(_ sender: UIImageView) {
        shadowView.animateAvatar()
    }
    @IBAction func chatButtonPressed(_ sender: UIButton) {
        sender.pulsate()
    }
    
    //Метод подготавливает переиспользуемую ячейку для повторного использования делегатом тейбл вью
    override func prepareForReuse() {
        super.prepareForReuse()
        self.friendsName.text = nil
        self.friendsPhoto.image = nil
        self.statusOnline.image = nil
        
    }
    
    //Метод конфигурации данных ячейки
    func configure(with user: User) {
        self.friendsName.text = "\(user.firstName) \(user.lastName)"
        //Статус обычный
        self.friendsStatus.textColor = .lightGray
        self.friendsStatus.text = "\(user.status)"
        
        self.cityLabel.textColor = .lightGray
        self.cityLabel.text = "\(user.city)"
        
        let url = URL(string: user.photo100)
        self.friendsPhoto.kf.setImage(with: url)
        //Статус в сети или нет
        if user.statusOnline == 1 {
            self.statusOnline.isHidden = false
        } else {
            self.statusOnline.isHidden = true
        }
        
    }

}



