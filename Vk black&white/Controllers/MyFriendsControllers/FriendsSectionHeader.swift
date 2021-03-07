//
//  FriendsSectionHeader.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 14.02.2021.
//

import UIKit

class FriendsSectionHeader: UITableViewHeaderFooterView {
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel?.text = ""
        self.detailTextLabel?.text = ""
    }
}
