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
    private let downloadVM = DownloadVM()
    
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
        
        let input = DownloadVM.Input(downloadTrigger: Observable.just(()))
        
        let output = downloadVM.transform(input: input)
        
        output.savedMedia
            .bind(to: downloadView.collectionView.rx.items(cellIdentifier: DefaultCollectionViewCell.identifier, cellType: DefaultCollectionViewCell.self)) {
                (item, element, cell) in
                cell.configureDownload(.table, title: element.title, image: "\(element.id)")
            }
            .disposed(by: disposeBag)
    }
}
