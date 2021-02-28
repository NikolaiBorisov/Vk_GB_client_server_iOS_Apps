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
                    
                    do {
                        try RealmManager.save(items: friends)
                    } catch {
                        print(error)
                    }
                    
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
                    
                    do {
                        try RealmManager.save(items: photos)
                    } catch {
                        print(error)
                    }
                    
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
                    
                    do {
                        try RealmManager.save(items: groups)
                    } catch {
                        print(error)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    //MARK: -Global Groups Search
    
    static func searchGroup(token: String, group name: String, completion: @escaping ([Group]) -> Void) {
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": token,
            "q": name,
            "v": "5.130"
        ]
        AF.request(NetworkManager.baseUrl + path,
                   method: .get,
                   parameters: params)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let allJSONGroups = json["response"]["items"].arrayValue
                    let allGroups = allJSONGroups.compactMap { Group($0) }
                    completion(allGroups)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
