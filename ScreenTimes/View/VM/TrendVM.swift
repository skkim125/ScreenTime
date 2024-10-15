//
//  TrendVM.swift
//  ScreenTimes
//
//  Created by 최대성 on 10/10/24.
//

import Foundation
import RxSwift
import RxCocoa

final class TrendVM: BaseViewModel {
    
    struct Input {
        let trendTrigger: Observable<Void>
    }
    struct Output {
        let randomContent: PublishSubject<String>
        let trendMovieList: PublishSubject<[MovieResult]>
        let trendTVList: PublishSubject<[TVResult]>
        let genre: PublishSubject<String>
        let networkError: PublishSubject<Void>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        
        let trendMovieList = PublishSubject<[MovieResult]>()
        let trendTVList = PublishSubject<[TVResult]>()
        let networkError = PublishSubject<Void>()
        let randomContent = PublishSubject<String>()
        let genre = PublishSubject<String>()
        var genreID = 0
        
        input.trendTrigger
            .flatMap {
                Single.zip(
                    NetworkManager.request(router: .trendingMovie, model: Movie.self),
                    NetworkManager.request(router: .trendingTV, model: TV.self)
                )
            }
            .flatMap { movieResult, tvResult -> Observable<Genre?> in
                
                guard let movieResults = movieResult?.results,
                      let tvResults = tvResult?.results else {
                    return Observable.just(nil)
                }
                
                let limitedMovieResults = Array(movieResults.prefix(10))
                let limitedTVResults = Array(tvResults.prefix(10))
                
                trendMovieList.onNext(limitedMovieResults)
                trendTVList.onNext(limitedTVResults)
                
                let isMovieSelected = Bool.random()
                
                if isMovieSelected {
                    let randomMovie = movieResults[Int.random(in: 1...10)]
                    randomContent.onNext(randomMovie.poster_path ?? "")
                    genreID = randomMovie.genre_ids.first ?? 0
                    
                } else {
                    let randomTV = tvResults[Int.random(in: 1...10)]
                    randomContent.onNext(randomTV.poster_path ?? "")
                    genreID = randomTV.genre_ids.first ?? 0
                }
                
                return NetworkManager.request(router: .genreMovie, model: Genre.self).asObservable()
            }
            .subscribe(with: self, onNext: { owner, genreResult in
                guard let genres = genreResult?.genres else { return }
                
                if let matchedGenre = genres.first(where: { $0.id == genreID }) {
                    genre.onNext(matchedGenre.name)
                }
                
            }, onError: { owner, error in
                print("에러임")
                networkError.onNext(())
                print(error)
            })
            .disposed(by: disposeBag)
        
        return Output(randomContent: randomContent, 
                      trendMovieList: trendMovieList,
                      trendTVList: trendTVList,
                      genre: genre, 
                      networkError: networkError
        )
    }
}
