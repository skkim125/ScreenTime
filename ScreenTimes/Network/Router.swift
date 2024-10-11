//
//  Router.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/9/24.
//

import Foundation
import Alamofire

enum Router {
    case trendingMovie
    case trendingTV
    case genreMovie
    case genreTV
    case searchMovie(query: String, page: Int)
    case searchTV(query: String, page: Int)
}

extension Router: TargetType {
    var method: Alamofire.HTTPMethod {
        switch self {
        case .trendingMovie, .trendingTV, .genreMovie, .genreTV, .searchMovie, .searchTV:
            return .get
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .trendingMovie, .trendingTV, .genreMovie, .genreTV:
            return [
                URLQueryItem(name: "language", value: "ko_KR")
            ]
        case .searchMovie(let query, let page),
                .searchTV(let query, let page):
            return [
                URLQueryItem(name: "language", value: "ko_KR"),
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: String(page))
            ]
        }
    }
    
    var body: Data? {
        return nil
    }
    
    var baseURL: String {
        return APIURL.base.urlString
    }
    
    var path: String {
        switch self {
        case .trendingMovie:
            return APIURL.trendingMovie.urlString
        case .trendingTV:
            return APIURL.trendingTV.urlString
        case .genreMovie:
            return APIURL.genreMovie.urlString
        case .genreTV:
            return APIURL.genreTV.urlString
        case .searchMovie:
            return APIURL.searchMovie.urlString
        case .searchTV:
            return APIURL.searchTV.urlString
        }
    }
    
    var header: [String: String] {
        guard let apikey = Bundle.main.apikey else {
            print("❌❌❌  API 키를 로드하지 못 했습니다  ❌❌❌")
            return [:]
        }
        switch self {
        case .trendingMovie, .trendingTV, .genreMovie, .genreTV, .searchMovie, .searchTV:
            return [
                Header.accept.rawValue: Header.acceptValue.rawValue,
                Header.authorization.rawValue: apikey
            ]
        }
    }
}
