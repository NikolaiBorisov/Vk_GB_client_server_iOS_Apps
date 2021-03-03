//
//  ClassPhotoVK.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 12.02.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class Photo: Object, Codable {
    @objc dynamic var id: Int = 0
    var sizes = List<PhotoSize>() //This property cannot be declared as a @objc dynamic
    
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        let tempArray: [PhotoSize] = json["sizes"].arrayValue.compactMap { PhotoSize ($0) }
        tempArray.forEach { (photosize) in
            self.sizes.append(photosize)
        }
        //self.sizes = json["sizes"].arrayValue.compactMap{ PhotoSize($0) } //Функция compactMap удаляет значения nil  из массива, тип возвращаемого значения больше не является опциональным
    }
    
    convenience init(id: Int, sizes: [PhotoSize]) {
        self.init()
        self.id = id
        sizes.forEach { (photosize) in
            self.sizes.append(photosize)
        }
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

class PhotoSize: Object, Codable {
    @objc dynamic var type: String = ""
    @objc dynamic var height: Int = 0
    @objc dynamic var width: Int = 0
    @objc dynamic var url: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        self.type = json["type"].stringValue
        self.height = json["height"].intValue
        self.width = json["width"].intValue
        self.url = json["url"].stringValue
    }
    
    convenience init(type: String, height: Int, width: Int, url: String) {
        self.init()
        self.type = type
        self.height = height
        self.width = width
        self.url = url
    }
}
