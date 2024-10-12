
//  TestNetwork.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/9/24.

import UIKit
import RxSwift
import RxCocoa

//class TestNetworkVC: UIViewController {
//    
//    private let disposeBag = DisposeBag()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        similarMovie()
//        similarTV()
//        castMovie()
//        castTV()
//     }
//    
//    private func similarMovie() {
//        NetworkManager.request(router: Router.similarMovie(id: 1022789), model: Movie.self)
//            .subscribe(onSuccess: { response in
//                guard let response else { return }
//                for movie in response.results {
//                    print("🍿 --- movie title", movie.title)
//                }
//            }, onFailure: { error in
//                print("similarMovie error", error)
//            })
//            .disposed(by: disposeBag)
//    }
//    
//    private func similarTV() {
//        print(#function)
//        NetworkManager.request(router: Router.similarTV(id: 84773), model: TV.self)
//            .subscribe(onSuccess: { response in
//                guard let response else { return }
//                for tv in response.results {
//                    print("📺 --- tv title", tv.name)
//                    print(tv.poster_path)
//                }
//            }, onFailure: { error in
//                print("similarTV error", error)
//            })
//            .disposed(by: disposeBag)
//    }
//    
//    private func castMovie() {
//        NetworkManager.request(router: Router.castMovie(id: 1022789), model: Cast.self)
//            .subscribe(onSuccess: { response in
//                guard let response else { return }
//                for cast in response.cast {
//                    print("🍿 --- movie cast name", cast.name)
//                }
//                for crew in response.crew {
//                    print("🍿", crew.name)
//                }
//            }, onFailure: { error in
//                print("similarTV error", error)
//            })
//            .disposed(by: disposeBag)
//    }
//    
//    private func castTV() {
//        NetworkManager.request(router: Router.castTV(id: 84773), model: Cast.self)
//            .subscribe(onSuccess: { response in
//                guard let response else { return }
//                for cast in response.cast {
//                    print("📺 --- tv cast name", cast.name)
//                }
//                for crew in response.crew {
//                    print("📺", crew.name)
//                }
//            }, onFailure: { error in
//                print("similarTV error", error)
//            })
//            .disposed(by: disposeBag)
//    }
//    
//}

