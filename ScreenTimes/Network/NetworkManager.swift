//
//  NetworkManager.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/9/24.
//

import Foundation
import Alamofire
import RxSwift

struct NetworkManager {
    
    private init() { }
    
    static func request<T: Decodable>(_ router: Router) -> Single<T> {
        return Single.create { single in
            do {
                let request = try router.asURLRequest()
                AF.request(request).responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        single(.success(value))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            } catch {
                single(.failure(error))
            }
            return Disposables.create()
        }
    }
}
