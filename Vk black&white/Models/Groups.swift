//
//  Groups.swift
//  Vk black&white
//
//  Created by Macbook on 11.12.2020.
//

import UIKit

struct Groups {
    var title: String
    var photo: UIImage?
}

final class GroupFactory {
    static func makeGroup() -> [Groups] {
        let gb =  Groups(title: "GeekBrains", photo: UIImage(named: "Geeks"))
        let sb = Groups(title: "SkillBox", photo: UIImage(named: "Skbox"))
        let net = Groups(title: "Netology", photo: UIImage(named: "Net"))
        let mail =  Groups(title: "Mail.ru", photo: UIImage(named: "Mail"))
        let yan = Groups(title: "Yandex.ru", photo: UIImage(named: "Yandex.ru"))
        let go = Groups(title: "Google.com", photo: UIImage(named: "Google"))
        
        return [gb, sb, net, mail, yan, go]
    }
}
