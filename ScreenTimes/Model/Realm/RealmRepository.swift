//
//  RealmRepository.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/11/24.
//

import UIKit
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
    
    func isExistSave(mediaId: Int) -> Bool {
        return realm.objects(Save.self).filter("mediaId == %@", mediaId).first != nil
    }
    
    func fetchAllSaves() -> [Save] {
        return Array(realm.objects(Save.self))
    }
    
    func loadImageToDocument(filename: String) -> UIImage? {
        
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")
        }
    }
}
