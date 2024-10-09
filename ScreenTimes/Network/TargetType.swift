//
//  Network.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/8/24.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var header: [String: String] { get }
    var parameters: String? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var request = try URLRequest(url: url.appendingPathComponent(path), method: method)
        var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
        components?.queryItems = queryItems
        request.allHTTPHeaderFields = header
        request.httpBody = body
        request.url = components?.url
        return request
    }
}
