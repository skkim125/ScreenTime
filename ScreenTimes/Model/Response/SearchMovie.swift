//
//  SearchMovie.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/9/24.
//

import Foundation

struct SearchMovie: Decodable {
    var page: Int
    var results: [MovieResult]
    let total_pages: Int
    let total_results: Int
}
