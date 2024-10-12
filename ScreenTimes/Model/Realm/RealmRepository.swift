//
//  RealmRepository.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/11/24.
//

import Foundation
import RealmSwift

final class RealmRepository {
    private let realm = try! Realm()
    
    func addSave(_ item: Save) {
        do {
            try realm.write {
                realm.add(item)
                print(realm.configuration.fileURL)
            }
        } catch {
            print("AddSave Failed")
        }
    }
    
    func deleteSave(_ item: Save) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("delete Failed")
        }
    }
    
    func isExistSave(id: Int) -> Bool {
        if let _ = realm.object(ofType: Save.self, forPrimaryKey: id) {
            return true
        } else {
            return false
        }
    }
}
