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
    private let searchVM = SearchVM()
    
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
        let setSearch = PublishSubject<String>()
        let input = SearchVM.Input(trigger: BehaviorSubject(value: ()), setSearch: setSearch)
        let output = searchVM.transform(input)
        
        searchView.searchController.searchBar.rx.text.orEmpty
            .bind(to: setSearch)
            .disposed(by: disposeBag)
        
        output.movieArray
            .bind(to: searchView.collectionView.rx.items(cellIdentifier: DefaultCollectionViewCell.identifier, cellType: DefaultCollectionViewCell.self)) { [weak self]
                (item, element, cell) in
                guard let self = self else { return }
                
                let data = Detail(backdrop_path: element.backdrop_path, id: element.id, name: element.title, overview: element.overview, poster_path: element.poster_path, media_type: element.media_type ?? "", genre_ids: element.genre_ids, vote_average: element.vote_average)
                
                cell.configureCell(self.searchView.layoutType, media: data)
            }
            .disposed(by: disposeBag)
        
        output.collectionviewStatus
            .bind(with: self) { owner, value in
                owner.searchView.infoLabel.rx.isHidden.onNext(value)
                owner.searchView.collectionView.rx.isHidden.onNext(value)
                owner.searchView.emptyLabel.rx.isHidden.onNext(!value)
            }
            .disposed(by: disposeBag)
        
        output.labelText
            .bind(with: self) { owner, value in
                owner.searchView.infoLabel.rx.text.onNext(value)
            }
            .disposed(by: disposeBag)
        
        output.collectionviewType
            .bind(with: self) { owner, value in
                owner.searchView.rx.layoutType.onNext(value)
                owner.searchView.collectionView.rx.collectionViewLayout.onNext(owner.searchView.defaultCollectionViewLayout(value))
            }
            .disposed(by: disposeBag)
        
        searchView.collectionView.rx.modelSelected(MovieResult.self)
            .bind(with: self) { owner, result in
                
                let vc = DetailViewController()
                let data = Detail(backdrop_path: result.backdrop_path, id: result.id, name: result.title, overview: result.overview, poster_path: result.poster_path, media_type: result.media_type ?? "", genre_ids: result.genre_ids, vote_average: result.vote_average)
                
                vc.media = data
                
                owner.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
