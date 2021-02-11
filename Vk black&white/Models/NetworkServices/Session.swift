//
//  Session.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 05.02.2021.
//

import Foundation
import Alamofire

class Session {
    
    private init() {}
    static let shared = Session()
    
    //Сохранить токен в синглтоне Session;
    var token = "" //To store Vk token
    var userId = Int() //To store user Vk id
}

