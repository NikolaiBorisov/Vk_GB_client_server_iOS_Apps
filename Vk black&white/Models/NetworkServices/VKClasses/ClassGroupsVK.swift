//
//  ClassGroupsVK.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 12.02.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Group {
    
    let id: Int
    let name: String
    let photo100: String
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo100 = json["photo_100"].stringValue
    }
}

extension Group: Equatable {}

//struct GroupResponse: Codable {
//    let response: Response
//
//    struct Response: Codable {
//        let items: [GroupsVk]
//    }
//}
//
//struct MyGroupsSection {
//    var title: String
//    var items: [GroupsVk]
//}
//
//class GroupsVk: Codable {
//    let id: Int = 0
//    var name: String = ""
//    let screenName: String = ""
//    let isClosed: Int = 0
//    let type: String = ""
//    let isAdmin: Int = 0
//    let isMember: Int = 0
//    let isAdvertiser: Int = 0
//    var photo200: String? = ""
//
//    enum Codingkeys: String, CodingKey {
//
//        case id
//        case name
//        case screenName = "screen_name"
//        case isClosed = "is_closed"
//        case type
//        case isAdmin  = "is_admin"
//        case isMember = "is_member"
//        case isAdvertiser = "is_advertiser"
//        case photo200 = "photo_200"
//
//    }
//
//    required init(from decoder: Decoder) throws {
//        let groupsContainer = try decoder.container(keyedBy: Codingkeys.self)
//        self.photo200 = try groupsContainer.decode(String?.self, forKey: .photo200)!
//        self.name = try groupsContainer.decode(String.self, forKey: .name)
//    }
//}
//
//class LoadGroupsVK {
//
//    static func loadGroups(token: String, completion: @escaping ([GroupsVk]) -> Void) {
//
//        let baseURL = "https://api.vk.com"
//        let path = "/method/groups.get"
//        let url = baseURL + path
//
//        let params: Parameters = [
//            "access_token": token,
//            "extended": 1,
//            "v": "5.92"
//        ]
//
//        AF.request(url, method: .get, parameters: params).responseData { (response) in
//
//            do {
//                let group = try JSONDecoder().decode(GroupResponse.self, from: response.value!)
//                completion(group.response.items)
//                print(group)
//            } catch {
//                print(error)
//            }
//        }
//    }
//}
