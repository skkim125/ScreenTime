//
//  SearchTV.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/9/24.
//

import Foundation

struct SearchTV: Decodable {
    var page: Int
    var results: [searchTVResults]
    let total_pages: Int
    let total_results: Int
}

struct searchTVResults: Decodable {
    let id: Int
    let name: String?
    let overview: String?
    let poster_path: String?
    let original_name: String?
}
