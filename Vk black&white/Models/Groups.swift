//
//  Groups.swift
//  Vk black&white
//
//  Created by Macbook on 11.12.2020.
//

import UIKit

struct AllGroupsSection {
    var title: String
    var items: [AllGroups]
}

struct AllGroups {
    var groupName: String
    var groupImage: UIImage?
}

final class Groups {
    static func makeGroups() -> [AllGroups] {
        let gb =  AllGroups(groupName: "GeekBrains", groupImage: UIImage(named: "Geeks"))
        let sb = AllGroups(groupName: "SkillBox", groupImage: UIImage(named: "Skbox"))
        let net = AllGroups(groupName: "Netology", groupImage: UIImage(named: "Net"))
        let mail =  AllGroups(groupName: "Mail.ru", groupImage: UIImage(named: "Mail"))
        let yan = AllGroups(groupName: "Yandex.ru", groupImage: UIImage(named: "Yandex.ru"))
        let go = AllGroups(groupName: "Google.com", groupImage: UIImage(named: "Google"))
        
        return [gb, sb, net, mail, yan, go]
    }
}
