//
//  AllGroupsHeader.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 01.03.2021.
//

import Foundation

class AllGroupsHeader: UITableViewHeaderFooterView {
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
