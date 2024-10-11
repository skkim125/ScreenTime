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
        let genre: PublishSubject<String>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let trendMovieList = PublishSubject<[MovieResult]>()
        let trendTVList = PublishSubject<[TVResult]>()
        
        let randomContent = PublishSubject<String>()
        let genre = PublishSubject<String>()
        var genreID = 0
        
        input.trendTrigger
            .flatMap {
                NetworkManager.request(router: .trendingMovie, model: Movie.self)
            }
            .subscribe(with: self, onNext: { owner, result in
                
                
                guard let result = result else { return print("결과값 없음.")}
                
                let limitedResults = Array(result.results.prefix(10))
                trendMovieList.onNext(limitedResults)
                
                let random = result.results[Int.random(in: 1...10)]
                
                randomContent.onNext(random.poster_path ?? "")
                
                genreID = random.genre_ids.first ?? 0
                
                
            }, onError: { owner, error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        input.trendTrigger
            .flatMap {
                NetworkManager.request(router: .trendingTV, model: TV.self)
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
        
        
        input.trendTrigger
            .flatMap {
                NetworkManager.request(router: .genreMovie, model: Genre.self)
            }
            .subscribe(with: self) { owner, result in
                guard let result = result?.genres else{ return }
                
                for i in 0..<result.count {
                    if genreID == result[i].id {
                        print("장르 id",genreID, result[i].id, result[i].name)
                        genre.onNext(result[i].name)
                        break
                    }
                }
            }
            .disposed(by: disposeBag)

        
        
        return Output(randomContent: randomContent, trendMovieList: trendMovieList, trendTVList: trendTVList, genre: genre)
    }
    
    
}
