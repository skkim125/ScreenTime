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
    private var movieArray: [MovieResult] = []
    private var trendArray: [MovieResult] = []
    private var search: String = ""
    private var currentPage = 1
    private var isLoading = false
    private var totalPages = 1
    
    struct Input {
        let trigger: BehaviorSubject<Void>
        let setSearch: PublishSubject<String>
        let prefetching: PublishSubject<Void>
    }
    
    struct Output {
        let movieArray: BehaviorSubject<[MovieResult]>
        let collectionviewStatus: PublishSubject<Bool>
        let collectionviewType: PublishSubject<CVType>
        let labelText: PublishSubject<String>
        let currentPage: BehaviorSubject<Int>
    }
    
    func transform(_ input: Input) -> Output {
        let movieArray = BehaviorSubject<[MovieResult]>(value: [])
        let setTrend = PublishSubject<Void>()
        let collectionviewStatus = PublishSubject<Bool>()
        let collectionviewType = PublishSubject<CVType>()
        let setSearch = PublishSubject<String>()
        let labelText = PublishSubject<String>()
        let currentPage = BehaviorSubject<Int>(value: 1)
        
        input.trigger
            .bind(with: self) { owner, _ in
                NetworkManager.request(router: .trendingMovie, model: Movie.self)
                    .subscribe { trend in
                        guard let trend = trend else { return }
                        owner.trendArray = trend.results
                        owner.movieArray.append(contentsOf: owner.trendArray)
                        movieArray.onNext(owner.movieArray)
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
                    owner.search = ""
                    owner.currentPage = 1
                    setTrend.onNext(())
                    collectionviewStatus.onNext(false)
                } else {
                    owner.currentPage = 1
                    owner.search = text
                    print("검색어", text)
                    setSearch.onNext(text)
                }
                
                currentPage.onNext(owner.currentPage)
            }
            .disposed(by: disposeBag)
        
        setSearch
            .bind(with: self) { owner, value in
                NetworkManager.request(router: .searchMovie(query: value, page: owner.currentPage), model: Movie.self)
                    .subscribe { search  in
                        guard let search = search else { return }
                        if search.results.isEmpty && search.total_results == 0 {
                            movieArray.onNext(owner.movieArray)
                            collectionviewStatus.onNext(true)
                            owner.currentPage = 1
                            currentPage.onNext(owner.currentPage)
                            print("현재 페이지", owner.currentPage)
                            setTrend.onNext(())
                        } else {
                            if owner.currentPage == 1 {
                                owner.movieArray = []
                            }
                            owner.movieArray.append(contentsOf: search.results)
                            movieArray.onNext(owner.movieArray)
                            collectionviewStatus.onNext(false)
                            collectionviewType.onNext(.threeCell)
                            owner.totalPages = search.total_pages
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
                if owner.search.isEmpty {
                    collectionviewStatus.onNext(false)
                }
                owner.movieArray = value
                movieArray.onNext(owner.movieArray)
                collectionviewType.onNext(.table)
                labelText.onNext("추천 시리즈 & 영화")
            }
            .disposed(by: disposeBag)
        
        input.prefetching
            .bind(with: self) { owner, _ in
                if owner.currentPage < owner.totalPages {
                    owner.currentPage += 1
                    currentPage.onNext(owner.currentPage)
                    setSearch.onNext(owner.search)
                }
            }
            .disposed(by: disposeBag)
        
        
        return Output(movieArray: movieArray, collectionviewStatus: collectionviewStatus, collectionviewType: collectionviewType, labelText: labelText, currentPage: currentPage)
    }
    
}
