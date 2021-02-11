//
//  RandomStatus.swift
//  Vk black&white
//
//  Created by Macbook on 20.12.2020.
//

import UIKit
//Friend's random status
extension UITableViewController {
    
    func createStatus() {
        enum UserSatus: String, CaseIterable {
            case online = "Online"
            case offline = "Offline"
            static func setRandomStatus() -> UserSatus {
                return UserSatus.allCases[Int.random(in: 0...1)]
            }
        }
    }
}
