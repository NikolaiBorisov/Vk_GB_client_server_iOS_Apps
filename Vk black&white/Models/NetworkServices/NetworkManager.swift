//
//  NetworkManager.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 10.02.2021.
//

import Foundation
import  Alamofire
import SwiftyJSON

class NetworkManager {
    
    private static let baseUrl = "https://api.vk.com"
    private static let version = "5.130"
    
    //MARK:- Load Friends
    func loadFriends(completion: @escaping ([User]) -> Void) {
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": NetworkManager.version,
            "fields": "photo_200"
        ]
        
        AF.request(NetworkManager.baseUrl + path,
                   method: .get,
                   parameters: params)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let friendsJSONList = json["response"]["items"].arrayValue
                    let friends = friendsJSONList.compactMap { User($0) }
                    completion(friends)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    //MARK:- Load Friends Photos
    
    func loadPhotos(for userId: Int, completion: @escaping ([Photo]) -> Void) {
        let path = "/method/photos.getAll"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": NetworkManager.version,
            "extended": 1,
            "owner_id": "\(userId)"
        ]
        
        AF.request(NetworkManager.baseUrl + path,
                   method: .get,
                   parameters: params)
            .response { response in
                switch response.result {
                case .success(let data):
                    guard
                    let data = data else { return }
                    let json = JSON(data)
                    let photoJSONs = json["response"]["items"].arrayValue
                    let photos = photoJSONs.compactMap { Photo($0) }
                    completion(photos)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    //MARK:- Load Groups
    
    func loadGroups(completion: @escaping ([Group]) -> Void) {
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": NetworkManager.version,
            "extended": 1
        ]
        
        AF.request(NetworkManager.baseUrl + path,
                   method: .get,
                   parameters: params)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let groupJSONs = json["response"]["items"].arrayValue
                    let groups = groupJSONs.compactMap { Group($0) }
                    completion(groups)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    //MARK: - Group Search
    static func groupSearch(by query: String) {
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "extended": 1,
            "v": NetworkManager.version,
            "q": query,
            "type": "group"
        ]
        
        AF.request(self.baseUrl + path,
                   method: .get,
                   parameters: params)
            .responseJSON { response in
                guard let json = response.value else { return }
                print("Global Groups: ", json)
            }
    }
    
}

//let accessToken = Session.shared.token
//
//     func loadFriends(completion: @escaping ([User]) -> Void) {
//
//        let baseURL = ""
//        let path = "/method/friends.get"
//        let url = baseURL + path
//
//        let params: Parameters = [
//            "access_token": Session.shared.token,
//            "fields": "photo_200",
//            "v": "5.92"
//        ]
//
//        AF.request(url,
//                   method: .get,
//                   parameters: params)
//            .responseData { response in
//            //guard let data = response.value else { return }
//
//            do {
//                let user = try JSONDecoder().decode(MainUserResponse.self, from: response.value!)
//                completion(user.response.items)
//                print(user)
//            } catch {
//                print(error)
//            }
//        }
//    }

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
//    let apiURL = ""
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
