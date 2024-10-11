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
    case similarMovie(id: Int)
    case similarTV(id: Int)
    case castMovie(id: Int)
    case castTV(id: Int)
}

extension Router: TargetType {
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .trendingMovie, .trendingTV, .genreMovie, .genreTV, .searchMovie, .searchTV, .similarMovie, .similarTV, .castMovie, .castTV:
            return .get
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .trendingMovie, .trendingTV, .genreMovie, .genreTV, .similarMovie, .similarTV, .castMovie, .castTV:
            return [
                URLQueryItem(name: "language", value: "ko-KR")
            ]
        case .searchMovie(let query, let page),
                .searchTV(let query, let page):
            return [
                URLQueryItem(name: "language", value: "ko-KR"),
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
        case .similarMovie(let id):
            return APIURL.similarMovie(id: id).urlString
        case .similarTV(let id):
            return APIURL.similarTV(id: id).urlString
        case .castMovie(let id):
            return APIURL.castMovie(id: id).urlString
        case .castTV(let id):
            return APIURL.castTV(id: id).urlString
        }
    }
    
    var header: [String: String] {
        guard let apikey = Bundle.main.apikey else {
            print("❌❌❌  API 키를 로드하지 못 했습니다  ❌❌❌")
            return [:]
        }

        switch self {
        case .trendingMovie, .trendingTV, .genreMovie, .genreTV, .searchMovie, .searchTV, .similarMovie, .similarTV, .castMovie, .castTV:
            return [
                Header.accept.rawValue: Header.acceptValue.rawValue,
                Header.authorization.rawValue: apikey
            ]
        }
    }
}
