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
        fetchTrendingTV()
        fetchGenreMovie()
        fetchGenreTV()
        fetchSearchMovie(query: "Harry")
        fetchSearchTV(query: "sherlock")
    }
    
    private func fetchTrendingMovie() {
        NetworkManager.request(Router.trendingMovie)
            .subscribe(onSuccess: { (response: TrendingMovie) in
                for movie in response.results {
                    print("1️⃣ movie title --- 🎬", movie.title)
                    print("1️⃣ overview --- 🎬", movie.overview)
                }
            }, onFailure: { error in
                    print("1️⃣ Trending Movie Error --- 🎬", error)
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchTrendingTV() {
        NetworkManager.request(Router.trendingTV)
            .subscribe(onSuccess: { (response: TrendingTV) in
                for tv in response.results {
                    print("2️⃣ TV title --- 📺", tv.name)
                    print("2️⃣ overview --- 📺", tv.overview)
                }
            }, onFailure: { error in
                    print("2️⃣ Trending TV Error --- 📺", error)
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchGenreMovie() {
        NetworkManager.request(Router.genreMovie)
            .subscribe(onSuccess: { (response: Genre) in
                for movieGenre in response.genres {
                    print("3️⃣ Movie Genre name --- 🎬", movieGenre.name)
                }
            }, onFailure: { error in
                    print("3️⃣ Movie Genre Error --- 🎬", error)
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchGenreTV() {
        NetworkManager.request(Router.genreTV)
            .subscribe(onSuccess: { (response: Genre) in
                for movieGenre in response.genres {
                    print("4️⃣ TV Genre name --- 📺", movieGenre.name)
                }
            }, onFailure: { error in
                    print("4️⃣ TV Genre Error --- 📺", error)
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchSearchMovie(query: String, page: Int = 1) {
        NetworkManager.request(Router.searchMovie(query: query, page: page))
            .subscribe(onSuccess: { (response: SearchMovie) in
                for searchMovie in response.results {
                    print("5️⃣ searchMovie --- 🎬", searchMovie.original_title ?? "제목 없음")
                }
            }, onFailure: { error in
                    print("5️⃣ searchMovie --- 🎬", error)
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchSearchTV(query: String, page: Int = 1) {
        NetworkManager.request(Router.searchTV(query: query, page: page))
            .subscribe(onSuccess: { (response: SearchTV) in
                for searchTV in response.results {
                    print("6️⃣ searchTV --- 📺", searchTV.original_name ?? "제목 없음")
                }
            }, onFailure: { error in
                    print("6️⃣ searchTV --- 📺", error)
            })
            .disposed(by: disposeBag)
    }
}
