//
//  SearchVM.swift
//  ScreenTimes
//
//  Created by 김상규 on 10/13/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchVM {
    private let disposeBag = DisposeBag()
    var trendArray: [MovieResult] = []
    
    struct Input {
        let trigger: BehaviorSubject<Void>
        let setSearch: PublishSubject<String>
    }
    
    struct Output {
        let movieArray: BehaviorSubject<[MovieResult]>
        let collectionviewStatus: PublishSubject<Bool>
        let collectionviewType: PublishSubject<CVType>
        let labelText: PublishSubject<String>
    }
    
    func transform(_ input: Input) -> Output {
        let movieArray = BehaviorSubject<[MovieResult]>(value: [])
        let setTrend = PublishSubject<Void>()
        let collectionviewStatus = PublishSubject<Bool>()
        let collectionviewType = PublishSubject<CVType>()
        let setSearch = PublishSubject<String>()
        let labelText = PublishSubject<String>()
        
        input.trigger
            .bind(with: self) { owner, _ in
                NetworkManager.request(router: .trendingMovie, model: Movie.self)
                    .subscribe { trend in
                        guard let trend = trend else { return }
//                        owner.trendArray = trend.results.map({ Detail(backdrop_path: $0.backdrop_path, id: $0.id, name: $0.title, overview: $0.overview, poster_path: $0.poster_path, media_type: $0.media_type ?? "", genre_ids: $0.genre_ids, vote_average: $0.vote_average) })
                        owner.trendArray = trend.results
                        movieArray.onNext(owner.trendArray)
                        labelText.onNext("추천 시리즈 & 영화")
                        setTrend.onNext(())
                    } onFailure: { error in
                        print(error)
                    }
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        input.setSearch
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                if text.trimmingCharacters(in: .whitespaces).isEmpty {
                    setTrend.onNext(())
                } else {
                    setSearch.onNext(text)
                }
            }
            .disposed(by: disposeBag)
        
        
        setSearch
            .bind(with: self) { owner, value in
                NetworkManager.request(router: .searchMovie(query: value, page: 1), model: Movie.self)
                    .subscribe { search  in
                        guard let search = search else { return }
                        if search.results.isEmpty && search.total_results == 0 {
                            movieArray.onNext([])
                            collectionviewStatus.onNext(true)
                        } else {
//                            let data = search.results.map({ Detail(backdrop_path: $0.backdrop_path, id: $0.id, name: $0.title, overview: $0.overview, poster_path: $0.poster_path, media_type: $0.media_type ?? "", genre_ids: $0.genre_ids, vote_average: $0.vote_average) })
                            movieArray.onNext(search.results)
                            collectionviewStatus.onNext(false)
                            collectionviewType.onNext(.threeCell)
                            labelText.onNext("영화 & 시리즈")
                        }
                    } onFailure: { error in
                        print(error)
                    }
                    .disposed(by: owner.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        setTrend
            .map({ [weak self] (_) -> [MovieResult] in
                guard let self = self else { return []}
                return self.trendArray
            })
            .bind(with: self) { owner, value in
                movieArray.onNext(value)
                collectionviewType.onNext(.table)
            }
            .disposed(by: disposeBag)
        
        
        return Output(movieArray: movieArray, collectionviewStatus: collectionviewStatus, collectionviewType: collectionviewType, labelText: labelText)
    }
    
}
