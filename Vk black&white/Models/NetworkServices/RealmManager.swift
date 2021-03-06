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
    
    static func getBy <T: Object>(type: T.Type) throws -> Results<T> {
        try Realm().objects(T.self)
    }
}

extension UITableView {
    func update(deletions: [Int],
                insertions: [Int],
                modifications: [Int],
                sections: Int = 0) {
        self.beginUpdates()
        deleteRows(at: deletions.map { IndexPath(row: $0, section: sections)}, with: .automatic)
        insertRows(at: insertions.map { IndexPath(row: $0, section: sections) }, with: .automatic)
        reloadRows(at: modifications.map { IndexPath(row: $0, section: sections) }, with: .automatic)
        self.endUpdates()
    }
}

extension UIViewController {
    func show(error: Error) {
        let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(okButton)
        present(alertVC, animated: true)
    }
}
