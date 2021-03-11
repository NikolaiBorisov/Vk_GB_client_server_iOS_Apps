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

class FriendsSections: Object {
    @objc dynamic var title: String = ""
    var items: [User] = []
    
    convenience init(title: String, items: [User]) {
        self.init()
        self.title = title
        self.items = items
    }
}

class User: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var city: City?
    
    @objc dynamic var status: String = ""
    @objc dynamic var statusOnline: Int = Int()
    
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photo100 = json["photo_200"].stringValue
        self.status = json["status"].stringValue
        self.statusOnline = json["online"].intValue
        
        let cityTitle = json["city"]["title"].stringValue
        self.city = City(title: cityTitle)
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
    
    override class func primaryKey() -> String? {
        "id"
    }
}

class City: Object {
    
    @objc dynamic var title: String = ""
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
