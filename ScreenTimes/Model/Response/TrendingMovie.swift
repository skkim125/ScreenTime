//
//  TrendingMovie.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/8/24.
//

import Foundation

struct TrendingMovie: Decodable {
    var page: Int
    var results: [MovieResult]
    let total_pages: Int
    let total_results: Int
}

struct MovieResult: Decodable {
    let backdrop_path: String?
    let id: Int
    let original_title: String?
    let overview: String
    let poster_path: String?
    let title: String
    let genre_ids: [Int]
    let release_date: String
    let vote_average: Double
}
