//
//  RealmRepository.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/11/24.
//

import UIKit
import RealmSwift
import UIKit

final class RealmRepository {
    private let realm = try! Realm()
    
    
    func fetchURL() {
        print(realm.configuration.fileURL ?? "")
        
    }
    
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
    
    func fetchSavedList() -> [Save] {
        let list = realm.objects(Save.self)
        
        return Array(list)
    }
    
    func isExistSave(id: Int) -> Bool {
        if let _ = realm.object(ofType: Save.self, forPrimaryKey: id) {
            return true
        }
        
        return false
    }
    func isExistSave(mediaId: Int) -> Bool {
        return realm.objects(Save.self).filter("mediaId == %@", mediaId).first != nil
    }
    
    func fetchAllSaves() -> [Save] {
        return Array(realm.objects(Save.self))
    }
}

extension RealmRepository {
    
    func saveImageToDocument(image: UIImage, filename: String) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
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
    
    func removeImageFromDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch {
                print("file remove error", error)
            }
            
        } else {
            print("file no exist")
        }
    }
}

