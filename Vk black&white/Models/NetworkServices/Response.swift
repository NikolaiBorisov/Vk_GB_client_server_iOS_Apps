//
//  Response.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 19.02.2021.
//

import Foundation

class Response<T: Codable>: Codable {
    let response: Items<T>
}

class Items<T: Codable>: Codable {
    let items: [T]
}

class ResponseJoin: Codable {
    let response: Int
}
