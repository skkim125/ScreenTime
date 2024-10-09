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
    private let searchView = SearchView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureNavigationBar() {
        navigationItem.searchController = searchView.searchController
    }
    
    override func bind() {
        let dummy = Observable.just([0,1,2,3,4,5])
        
        dummy
            .bind(to: searchView.collectionView.rx.items(cellIdentifier: DefaultCollectionViewCell.identifier, cellType: DefaultCollectionViewCell.self)) {
                (item, element, cell) in
                
                cell.configureView()
                cell.backgroundColor = .green
            }
            .disposed(by: disposeBag)
    }
}
