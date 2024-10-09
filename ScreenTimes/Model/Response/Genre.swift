//
//  GenreMovie.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/9/24.
//

import Foundation

struct Genre: Decodable {
    var genres: [GenreDetail]
}

struct GenreDetail: Decodable {
    let id: Int
    let name: String
}
