//
//  MyGroupsHeader.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 18.02.2021.
//

import UIKit

class MyGroupsHeader: UITableViewHeaderFooterView {
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel?.text = ""
        self.detailTextLabel?.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //corners rounding
        layer.cornerRadius = frame.height / 2
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        layer.masksToBounds = true
    }
    
}
