//
//  Users.swift
//  Vk black&white
//
//  Created by Macbook on 11.12.2020.
//

import UIKit

enum UserSatus: String, CaseIterable {
    case online = "Online"
    case offline = "Offline"
    static func setRandomStatus() -> UserSatus {
        return UserSatus.allCases[Int.random(in: 0...1)]
    }
}

struct User {
    var name: String
    var avatar: UIImage?
    var photos: [UIImage?]
}

final class FriendsFactory {
    static func makeFriends() -> [User] {
        
        let neo = User(name: "Mr. Anderson", avatar: UIImage(named: "Neo"), photos:
                        [UIImage(named: "NW1"),
                        UIImage(named: "NW22"),
                        UIImage(named: "NW3")])
        
        let trinity = User(name: "Trinity", avatar: UIImage(named: "Trinity"), photos:
                        [UIImage(named: "Trinity"),
                        UIImage(named: "TRW1"),
                        UIImage(named: "Tr4")])
        
        let morpheus = User(name: "Morpheus", avatar: UIImage(named: "Morpheus"), photos:
                        [UIImage(named: "Mor2"),
                        UIImage(named: "MR3W"),
                        UIImage(named: "Mor4")])
        
        let agent = User(name: "Agent Smith", avatar: UIImage(named: "AgentSmith"), photos:
                        [UIImage(named: "Ag2"),
                        UIImage(named: "Ag3"),
                        UIImage(named: "ASW")])
        
        let neoba = User(name: "Neoba", avatar: UIImage(named: "Neoba2-1"), photos:
                        [UIImage(named: "Neoba2"),
                        UIImage(named: "Neoba3-1"),
                        UIImage(named: "NB3")])
        
        return [neo, trinity, morpheus, agent, neoba]
    }
}
    
