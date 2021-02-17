//
//  Classes.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 12.02.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class User: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var photo100: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photo100 = json["photo_200"].stringValue
    }
    
    convenience init(id: Int, firstName: String, lastName: String, photo100: String) {
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.photo100 = photo100
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



