//
//  NetworkManager.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 10.02.2021.
//

import Foundation
import  Alamofire

//1st method

class NetworkManager {
    private static let sessionAF: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()

    static func loadGroups(token: String) {

        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"

        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.92"
        ]

        AF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            print(json)
        }
    }

    static func loadFriendsPhotos(token: String) {

        let baseURL = "https://api.vk.com"
        let path = "/method/photos.get"

        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.92",
            "album_id": "profile",
            //"owner_id": "" // где взять owner id?
        ]

        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            print(json)
        }
    }

    static func loadFriends(token: String) {

        let baseURL = "https://api.vk.com"
        let path = "/method/friends.get"

        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.92",
            "user_id": Session.shared.userId
        ]

        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            print(json)
        }
    }

    static func groupSearch(token: String, query: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.search"

        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.92",
            "q": query
        ]

        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            print(json)
        }
    }

}

//2nd method
//
//enum VKMethods: String {
//    case getGroups = "groups.get"
//    case getPhotos = "photos.get"
//    case getFriends = "friends.get"
//    case searchGroup = "groups.search"
//}
//
//class NetworkManager {
//
//    let apiURL = "https://api.vk.com/method/"
//    let version = "5.92"
//
//    var accessToken = Session.shared.token
//    var userId: Int
//
//    init(accessToken: String, userId: Int) {
//        self.accessToken = accessToken
//        self.userId = userId
//    }
//
//    private func makeRequest(accessToken: String,
//                             vkMethod: VKMethods,
//                             parameters: Parameters,
//                             httpMethod: HTTPMethod = .get) {
//        let requestURL = apiURL + vkMethod.rawValue
//        let defaultParams: Parameters = [
//            "access_token": accessToken,
//            "user_id": userId,
//            "v": version
//        ]
//        let finalParams = defaultParams.merging(parameters, uniquingKeysWith: { currentKey, _ in currentKey })
//
//        AF.request(requestURL, method: httpMethod, parameters: finalParams)
//            .validate()
//            .responseJSON { response in
//                print(response.value ?? 0) //?
//            }
//    }
//    func getFriends() {
//        let params: Parameters = [
//            "fields": "city," + "online"
//        ]
//        makeRequest(accessToken: accessToken, vkMethod: .getFriends, parameters: params)
//    }
//
//    func getGroups() {
//        let params: Parameters = [
//            "fields": "city," + "country",
//            "extended": 1
//        ]
//        makeRequest(accessToken: accessToken, vkMethod: .getGroups, parameters: params)
//    }
//
//    func getPhotos() {
//        let params: Parameters = [
//            //"owner_id": ownerId,
//            "extended": "1",
//            "album_id": "profile"
//        ]
//        makeRequest(accessToken: accessToken, vkMethod: .getPhotos, parameters: params)
//    }
//
//    func searchGroup(withTitle: String) {
//        let params: Parameters = [
//            "q": withTitle
//        ]
//        makeRequest(accessToken: accessToken, vkMethod: .searchGroup, parameters: params)
//    }
//
//}
