//
//  TrendingTV.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/9/24.
//

import Foundation

struct TV: Decodable {
    var page: Int
    var results: [TVResult]
    let total_pages: Int
    let total_results: Int
}

struct TVResult: Decodable {
    let backdrop_path: String?
    let id: Int
    let name: String
    let overview: String
    let poster_path: String?
    let media_type: String
    let genre_ids: [Int]
    let vote_average: Double
}
