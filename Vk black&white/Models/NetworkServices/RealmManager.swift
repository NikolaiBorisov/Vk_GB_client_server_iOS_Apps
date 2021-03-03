//
//  RealmManager.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 27.02.2021.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    //define all the functions which are responsible for the data storage in the DB
    static func save<T: Object>(items: [T],
                                configuration: Realm.Configuration = deleteIfMigration,
                                update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items, update: update)
        }
    }
}
