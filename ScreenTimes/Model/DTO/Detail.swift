//
//  Detail.swift
//  ScreenTimes
//
//  Created by 김상규 on 10/12/24.
//

import Foundation

struct Details: Decodable {
    var page: Int
    var results: [Detail]
    let total_pages: Int
    let total_results: Int
}

struct Detail: Decodable {
    let backdrop_path: String?
    let id: Int
    let name: String
    let overview: String
    let poster_path: String?
    let media_type: String
    let genre_ids: [Int]
    let vote_average: Double
}
