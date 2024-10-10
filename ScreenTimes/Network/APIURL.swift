//
//  APIURL.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/10/24.
//

import Foundation

enum APIURL {
    case base
    case trendingMovie
    case trendingTV
    case genreMovie
    case genreTV
    case searchMovie
    case searchTV
    
    var urlString: String {
        switch self {
        case .base:
            return "https://api.themoviedb.org/3/"
        case .trendingMovie:
            return "trending/movie/week"
        case .trendingTV:
            return "trending/tv/week"
        case .genreMovie:
            return "genre/movie/list"
        case .genreTV:
            return "genre/tv/list"
        case .searchMovie:
            return "search/movie"
        case .searchTV:
            return "search/tv"
        }
    }
}
