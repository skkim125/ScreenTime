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
        let randomContent: PublishSubject<String>
        let trendMovieList: PublishSubject<[MovieResult]>
        let trendTVList: PublishSubject<[TVResult]>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let trendMovieList = PublishSubject<[MovieResult]>()
        let trendTVList = PublishSubject<[TVResult]>()
        
        let randomContent = PublishSubject<String>()
        
        
        input.trendTrigger
            .flatMap {
                NetworkManager.requestTest(router: .trendingMovie, model: TrendingMovie.self)
            }
            .subscribe(with: self, onNext: { owner, result in
                
                print("여기?")
                
                guard let result = result else { return print("결과값 없음.")}
                
                let limitedResults = Array(result.results.prefix(10))
                trendMovieList.onNext(limitedResults)
                
                let random = result.results[Int.random(in: 1...10)].poster_path
                randomContent.onNext(random ?? "")
                
            }, onError: { owner, error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        input.trendTrigger
            .flatMap {
                NetworkManager.requestTest(router: .trendingTV, model: TrendingTV.self)
            }
            .subscribe(with: self, onNext: { owner, result in
                
                guard let result = result else { return print("결과값 없음.")}
                
                let limitedResults = Array(result.results.prefix(10))
                trendTVList.onNext(limitedResults)
                
                let random = result.results[Int.random(in: 1...10)].poster_path
                randomContent.onNext(random ?? "")
                
            }, onError: { owner, error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        
        return Output(randomContent: randomContent, trendMovieList: trendMovieList, trendTVList: trendTVList)
    }
    
    
}
