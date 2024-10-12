//
//  Realm.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/8/24.
//

import Foundation
import RealmSwift

class Save: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    
    convenience init(title: String, imageLink: String) {
        self.init()
        self.title = title
    }
}
