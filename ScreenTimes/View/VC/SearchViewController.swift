//
//  SearchViewController.swift
//  ScreenTimes
//
//  Created by 김상규 on 10/9/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    private let searchView = SearchView(frame: .zero, type: .table)
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = searchView
        view.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureNavigationBar() {
        searchView.searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchView.searchController
    }
    
    override func bind() {
        let dummy = PublishSubject<[Detail]>()
        var trendArray: [Detail] = []
        let setTrend = PublishSubject<Void>()
        let setSearch = PublishSubject<String>()
        
        NetworkManager.request(router: .trendingMovie, model: Movie.self)
            .subscribe { trend in
                guard let trend = trend else { return }
                trendArray = trend.results.map({ Detail(backdrop_path: $0.backdrop_path, id: $0.id, name: $0.title, overview: $0.overview, poster_path: $0.poster_path, media_type: $0.media_type ?? "", genre_ids: $0.genre_ids, vote_average: $0.vote_average) })
                dummy.onNext(trendArray)
                setTrend.onNext(())
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        dummy
            .bind(to: searchView.collectionView.rx.items(cellIdentifier: DefaultCollectionViewCell.identifier, cellType: DefaultCollectionViewCell.self)) { [weak self]
                (item, element, cell) in
                guard let self = self else { return }
                cell.configureCell(self.searchView.layoutType, media: element)
            }
            .disposed(by: disposeBag)
        
        searchView.searchController.searchBar.rx.text.orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                if text.trimmingCharacters(in: .whitespaces).isEmpty {
                    owner.searchView.infoLabel.rx.text.onNext("추천 시리즈 & 영화")
                    owner.searchView.infoLabel.rx.isHidden.onNext(false)
                    owner.searchView.emptyLabel.rx.isHidden.onNext(true)
                    owner.searchView.collectionView.rx.isHidden.onNext(false)
                    owner.searchView.collectionView.rx.collectionViewLayout.onNext(owner.searchView.defaultCollectionViewLayout(.table))
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
                            dummy.onNext([])
                            owner.searchView.infoLabel.rx.text.onNext("")
                            owner.searchView.infoLabel.rx.isHidden.onNext(true)
                            owner.searchView.emptyLabel.rx.isHidden.onNext(false)
                            owner.searchView.collectionView.rx.isHidden.onNext(true)
                        } else {
                            let data = search.results.map({ Detail(backdrop_path: $0.backdrop_path, id: $0.id, name: $0.title, overview: $0.overview, poster_path: $0.poster_path, media_type: $0.media_type ?? "", genre_ids: $0.genre_ids, vote_average: $0.vote_average) })
                            dummy.onNext(data)
                            owner.searchView.infoLabel.rx.text.onNext("영화 & 시리즈")
                            owner.searchView.infoLabel.rx.isHidden.onNext(false)
                            owner.searchView.emptyLabel.rx.isHidden.onNext(true)
                            owner.searchView.collectionView.rx.isHidden.onNext(false)
                            owner.searchView.rx.layoutType.onNext(.threeCell)
                            owner.searchView.collectionView.rx.collectionViewLayout.onNext(owner.searchView.defaultCollectionViewLayout(.threeCell))
                        }
                    } onFailure: { error in
                        print(error)
                    }
                    .disposed(by: owner.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        
        setTrend
            .map({ trendArray })
            .bind(with: self) { owner, value in
                dummy.onNext(value)
                owner.searchView.rx.layoutType.onNext(.table)
                owner.searchView.collectionView.rx.collectionViewLayout.onNext(owner.searchView.defaultCollectionViewLayout(.table))
            }
            .disposed(by: disposeBag)
    }
}
