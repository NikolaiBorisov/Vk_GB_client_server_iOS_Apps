//
//  ServerErrors.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 19.02.2021.
//

import Foundation

enum ServerErrors: Error {
    case noDataProvided
    case failedToDecode
    case errorTask
}
