//
//  Cast.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/11/24.
//

import Foundation

struct Cast: Decodable {
    let id: Int
    var cast: [CastResult]
    var crew: [CrewResult]
}

struct CastResult: Decodable {
    let name: String
}

struct CrewResult: Decodable {
    let name: String
}
