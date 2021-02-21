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
    
}
