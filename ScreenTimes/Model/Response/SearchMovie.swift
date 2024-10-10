//
//  SearchMovie.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/9/24.
//

import Foundation

struct SearchMovie: Decodable {
    var page: Int
    var results: [searchMovieResults]
    let total_pages: Int
    let total_results: Int
}

struct searchMovieResults: Decodable {
    let id: Int
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let title: String
}
