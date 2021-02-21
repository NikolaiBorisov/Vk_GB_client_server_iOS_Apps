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
    
    enum UserSatus: String, CaseIterable {
        case online = "Online"
        case offline = "Offline"
    }
    
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var photo100: String = ""
    var city: City?
    @objc dynamic var status: String = ""
    
    @objc dynamic var statusOnline: Int = Int()
    @objc dynamic var isOnline: Bool {
        self.statusOnline == 1
    }
    
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photo100 = json["photo_200"].stringValue
        self.status = json["status"].stringValue
        self.statusOnline = json["online"].intValue
        self.city = json["city"].object as? City
        
        
    }
    
    convenience init(id: Int, firstName: String, lastName: String, photo100: String, status: String, statusOnline: Int, city: City?) {
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.photo100 = photo100
        self.status = status
        self.statusOnline = statusOnline
        self.city = city
    }
}

class City: Object {
    @objc dynamic var title: String = ""
    
    convenience init(_ json: JSON) {
    self.init()
        self.title = json["title"].stringValue
    }
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
}

//class City: Decodable {
//    var title: String
//}
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



