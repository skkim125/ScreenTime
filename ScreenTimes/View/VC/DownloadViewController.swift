//
//  DownloadViewController.swift
//  ScreenTimes
//
//  Created by 김상규 on 10/10/24.
//

import UIKit
import RxSwift
import RxCocoa

final class DownloadViewController: BaseViewController {
    private let downloadView = DownloadView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = downloadView
        view.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureNavigationBar() {
        navigationItem.title = "다운로드 리스트"
        
    }
    
    override func bind() {
        let dummy = PublishSubject<[MovieResult]>()
        
        dummy
            .bind(to: downloadView.collectionView.rx.items(cellIdentifier: DefaultCollectionViewCell.identifier, cellType: DefaultCollectionViewCell.self)) { [weak self]
                (item, element, cell) in
                guard let self = self else { return }
                
                cell.configureCell(.table, movie: element)
            }
            .disposed(by: disposeBag)
    }
}
