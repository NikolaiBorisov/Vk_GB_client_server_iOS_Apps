//
//  Classes.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 12.02.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

struct User {

    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String

    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photo100 = json["photo_200"].stringValue
    }
}


//extension UserVK {
//
//    init(from decoder: Decoder) throws {
//        self.init()
//
//        let itemContainer = try decoder.container(keyedBy: Codingkeys.self)
//        self.id = try itemContainer.decode(Int.self, forKey: .id)
//        self.avatarURL = try itemContainer.decode(String.self, forKey: .avatarURL)
//        self.firstName = try itemContainer.decode(String.self, forKey: .firstName)
//        self.lastName = try itemContainer.decode(String.self, forKey: .lastName)
//    }
//}



