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

class Photo: Object {
    @objc dynamic var id: Int = 0
    var sizes: [PhotoSize] = [] //This property cannot be declared as a @objc dynamic
    
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.sizes = json["sizes"].arrayValue.compactMap{ PhotoSize($0) } //Функция compactMap удаляет значения nil  из массива, тип возвращаемого значения больше не является опциональным
    }
    
    convenience init(id: Int, sizes: [PhotoSize]) {
        self.init()
        self.id = id
        self.sizes = sizes
    }
}

class PhotoSize: Object {
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



//struct PhotoResponse: Decodable {
//    let response: Response
//
//    struct Response: Codable {
//        let items: [PhotoVK]
//    }
//}
//
//class PhotoVK: Codable {
//    var id: Int = 0
//    var albumId: Int = 0
//    var date: Int = 0
//    var ownerId: Int = 0
//    var postId: Int? = 0
//    var sizes: [Size] = []
//    var text: String = ""
//    var url: String = ""
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case albumId = "album_id"
//        case date
//        case ownerId = "owner_id"
//        case postId = "post_id"
//        case sizes
//        case text
//    }
//
//    enum CodingKeysPhotoSize: String, CodingKey {
//        case type
//        case url
//    }
//
//    required init(from decoder: Decoder) throws {
//        let photoContainer = try  decoder.container(keyedBy: CodingKeys.self)
//        var sizes = try photoContainer.nestedUnkeyedContainer(forKey: .sizes)
//        let sizeValues = try sizes.nestedContainer(keyedBy: CodingKeysPhotoSize.self)
//        self.url = try sizeValues.decode(String.self, forKey: .url)
//    }
//}
//
//struct Size: Codable {
//    var height: Int
//    var width: Int
//    var type: String
//    var url: String
//}
//
//class LoadFriendsPhotosVK {
//
//    static func loadFriendsPhotos(token: String, ownerId: Int, completion: @escaping ([PhotoVK]) -> Void) {
//
//        let baseURL = ""
//        let path = "/method/photos.get"
//        let url = baseURL + path
//
//        let params: Parameters = [
//            "access_token": token,
//            "extended": 1,
//            "v": "5.92",
//            "album_id": "profile",
//            "owner_id": ownerId
//        ]
//
//        AF.request(url, method: .get, parameters: params).responseData { response in
//
//            do {
//                let photo = try JSONDecoder().decode(PhotoResponse.self, from: response.value!)
//                completion(photo.response.items)
//                print(photo)
//            } catch {
//                print(error)
//            }
//        }
//    }
//}
