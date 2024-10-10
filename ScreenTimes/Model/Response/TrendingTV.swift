//
//  TrendingTV.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/9/24.
//

import Foundation

struct TrendingTV: Decodable {
    let results: [TVResult]
}

struct TVResult: Decodable {
    let backdrop_path: String?
    let id: Int
    let name: String
    let overview: String
    let poster_path: String?
    let genre_ids: [Int]
    let vote_average: Double
}
