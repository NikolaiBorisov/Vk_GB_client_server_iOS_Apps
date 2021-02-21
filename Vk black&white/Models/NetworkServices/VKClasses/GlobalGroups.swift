//
//  GlobalGroups.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 19.02.2021.
//

import Foundation
import SwiftyJSON
import RealmSwift

class GlobalGroups: Object {
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
    
}
