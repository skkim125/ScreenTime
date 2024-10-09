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
}

extension Router: TargetType {
    var method: Alamofire.HTTPMethod {
        switch self {
        case .trendingMovie, .trendingTV, .genreMovie, .genreTV:
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
        }
    }
    
    var header: [String: String] {
        switch self {
        case .trendingMovie, .trendingTV, .genreMovie, .genreTV:
            return [
                Header.accept.rawValue: Header.acceptValue.rawValue,
                Header.authorization.rawValue: APIKey.tmdbAccessToken
            ]
        }
    }
}
