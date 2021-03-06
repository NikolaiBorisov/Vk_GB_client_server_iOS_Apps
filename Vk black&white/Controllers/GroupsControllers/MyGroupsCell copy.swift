//
//  MyGroupsCell.swift
//  Vk black&white
//
//  Created by Macbook on 08.12.2020.
//

import UIKit

class MyGroupsCell: UITableViewCell {
    
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    
    @IBOutlet weak var myGroupsShadow: Shadow!
    @IBAction func animateMyGroupAvatar(_ sender: UIImageView) {
        myGroupsShadow.animateAvatar()
    }
    
    @IBOutlet weak var shadowGroupView: Shadow!
    @IBAction func animateGroupAvatar(_ sender: UIImageView) {
        shadowGroupView.animateAvatar()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.groupName.text = nil
        self.groupImage.image = nil
    }
    
    func configure(with group: Group) {
        self.groupName.text = group.name
        let url = URL(string: group.photo100)
        self.groupImage.kf.setImage(with: url)
    }
    
}
