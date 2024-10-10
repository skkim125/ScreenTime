//
//  TrendVM.swift
//  ScreenTimes
//
//  Created by 최대성 on 10/10/24.
//

import Foundation
import RxSwift
import RxCocoa


final class TrendVM {
    
    
    struct Input {
        let trendTrigger: Observable<Void>
    }
    struct Output {
        let trendMovieList: PublishSubject<[MovieResult]>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
//        print("dfdfdsfsdfdsf")
        let trendMovieList = PublishSubject<[MovieResult]>()
//        
        input.trendTrigger
            .flatMap {
                NetworkManager.requestTest(router: .trendingMovie, model: TrendingMovie.self)
            }
            .subscribe(with: self, onNext: { owner, result in
                
                guard let result = result else { return print("결과값 없음.")}
                
                let limitedResults = Array(result.results.prefix(10))
                trendMovieList.onNext(limitedResults)
                
            }, onError: { owner, error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        return Output(trendMovieList: trendMovieList)
    }
    
    
}
