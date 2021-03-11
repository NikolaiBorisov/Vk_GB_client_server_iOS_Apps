//
//  ClassGroupsVK.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 12.02.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

struct GroupsResponse<T: Decodable>: Decodable {
    var response: Response
    
    struct Response: Decodable {
        let count: Int?
        var items: [T]
    }
}

class Group: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo100: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo100 = json["photo_100"].stringValue
    }
    
    convenience init(id: Int, name: String, photo100: String) {
        self.init()
        self.id = id
        self.name = name
        self.photo100 = photo100
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

class GroupsSection: Object {
    @objc dynamic var title: String = ""
    var items: [Group] = []
    
    convenience init(title: String, items: [Group]) {
        self.init()
        self.title = title
        self.items = items
    }
}
