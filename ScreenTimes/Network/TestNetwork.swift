//
//  TestNetwork.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/9/24.
//

import UIKit
import RxSwift

class TestNetworkVC: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTrendingMovie()
    }
    
    private func fetchTrendingMovie() {
        NetworkManager.request(Router.trendingMovie)
            .subscribe(onSuccess: { (response: TrendingMovie) in
                for movie in response.results {
                    print("title", movie.title)
                    print("overview", movie.overview)
                }
            }, onFailure: { error in
                    print("Trending Movie Error", error)
            })
            .disposed(by: disposeBag)
    }
}
