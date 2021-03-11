//
//  AllGroupsCell.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 19.02.2021.
//

import UIKit
//Этот контроллер пока не используется!
class AllGroupsCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapOnAvatar(_:)))
        //imageCommunityView.addGestureRecognizer(tap)
        //imageCommunityView.isUserInteractionEnabled = true
    }
    
    @objc func tapOnAvatar(_ tapGestureRecognizer: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 1,
                       options: [.autoreverse],
                       animations: {
                        //let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        //self.imageCommunityView.transform = scale
                        //self.shadowView.transform = scale
                        
                       }) { _ in
            //self.imageCommunityView.transform = .identity
            //self.shadowView.transform = .identity
            print(#function)
        }
    }
    
}
