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
    @Persisted(indexed: true) var mediaId: Int
    @Persisted var title: String
    

    convenience init(mediaId: Int, title: String) {

        self.init()
        self.mediaId = mediaId
        self.title = title
    }
}
