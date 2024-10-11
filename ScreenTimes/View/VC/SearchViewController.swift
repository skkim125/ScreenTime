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
        let dummy = PublishSubject<[MovieResult]>()
        let trendArray = PublishSubject<[MovieResult]>()
        let searchArray = PublishSubject<[MovieResult]>()
        
        NetworkManager.request(.trendingMovie)
            .subscribe { (trend: TrendingMovie) in
                trendArray.onNext(trend.results)
                dummy.onNext(trend.results)
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        dummy
            .bind(to: searchView.collectionView.rx.items(cellIdentifier: DefaultCollectionViewCell.identifier, cellType: DefaultCollectionViewCell.self)) { [weak self]
                (item, element, cell) in
                guard let self = self else { return }
                cell.configureCell(self.searchView.layoutType, movie: element)
            }
            .disposed(by: disposeBag)
        
        searchView.searchController.searchBar.rx.text.orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                if text.trimmingCharacters(in: .whitespaces).isEmpty {
                    self.searchView.collectionView.rx.collectionViewLayout.onNext(owner.searchView.defaultCollectionViewLayout(.table))
                } else {
                    owner.searchView.collectionView.rx.collectionViewLayout.onNext(owner.searchView.defaultCollectionViewLayout(.threeCell))
                }
            }
            .disposed(by: disposeBag)
    }
}
