//
//  NetworkManager.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 10.02.2021.
//

import Foundation
import Alamofire
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
            "fields": "photo_200, online, status, city"
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
    
   static func searchGroup(token: String, group name: String, completion: @escaping ([Group]) -> Void) {
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": token,
            "q": name,
            "v": "5.130"
        ]
        AF.request(NetworkManager.baseUrl + path, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return }
            
            if let groups = try? JSONDecoder().decode(GroupsResponse.self, from: data).response.items {
                completion(groups)
                print(groups)
            }
        }
    }
//    //Create url constructor
//    var urlConstructor = URLComponents()
//    let constants = NetworkConstants()
//    let configuration: URLSessionConfiguration!
//    let session: URLSession!
//
//    init() {
//        urlConstructor.scheme = "https"
//        urlConstructor.host = "api.vk.com"
//        configuration = URLSessionConfiguration.default
//        session = URLSession(configuration: configuration)
//    }
//
//    func getAuthorizeRequest() -> URLRequest? {
//        urlConstructor.host = "oauth.vk.com"
//        urlConstructor.path = "/authorize"
//
//        urlConstructor.queryItems = [
//            URLQueryItem(name: "client_id", value: constants.clientID),
//            URLQueryItem(name: "scope", value: constants.scope),
//            URLQueryItem(name: "display", value: "mobile"),
//            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
//            URLQueryItem(name: "response_type", value: "token"),
//            URLQueryItem(name: "v", value: constants.versionAPI)
//        ]
//
//        guard
//            let url = urlConstructor.url else { return nil }
//        let request = URLRequest(url: url)
//        return request
//    }
//    //Search group method
//    func getSearchCommunity(text: String?, onComplete: @escaping ([Group]) -> Void, onError: @escaping (Error) -> Void) {
//        urlConstructor.path = "/method/groups.search"
//
//        urlConstructor.queryItems = [
//            URLQueryItem(name: "q", value: text),
//            URLQueryItem(name: "access_token", value: Session.shared.token),
//            URLQueryItem(name: "v", value: constants.versionAPI)
//        ]
//        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
//
//            if error != nil {
//                onError(ServerErrors.errorTask)
//            }
//
//            guard let data = data else {
//                onError(ServerErrors.noDataProvided)
//                return
//            }
//            guard let communities = try? JSONDecoder().decode(Response<Group>.self, from: data).response.items else {
//                onError(ServerErrors.failedToDecode)
//                return
//            }
//            DispatchQueue.main.async {
//                onComplete(communities)
//            }
//        }
//        task.resume()
//    }

}
