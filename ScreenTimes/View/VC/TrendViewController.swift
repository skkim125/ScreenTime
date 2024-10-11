//
//  TrendViewController.swift
//  TMDBCollaborate
//
//  Created by 최대성 on 10/9/24.
//

import UIKit
import RxSwift
import RxCocoa

final class TrendViewController: UIViewController {
    
    private let trendView = TrendView()
    private let list = BehaviorRelay(value: Array(1...10))
    private let disposeBag = DisposeBag()
    
    
    override func loadView() {
        view = trendView
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        configureNavigationBar()
        
        list  
            .bind(to: trendView.maincontentsCollectionView.rx.items(cellIdentifier: "TrendCollectionViewCell", cellType: TrendCollectionViewCell.self)) { (row, element, cell) in
            
//                cell.configureCell(text: "\(element)")
        }
        .disposed(by: disposeBag)
        list
            .bind(to: trendView.tvcontentsCollectionView.rx.items(cellIdentifier: "TrendCollectionViewCell", cellType: TrendCollectionViewCell.self)) { (row, element, cell) in
            
//                cell.configureCell(text: "\(element)")
        }
        .disposed(by: disposeBag)
    }
    
    private func configureNavigationBar() {
        
        let searchButton1 = UIBarButtonItem(image: UIImage(systemName: "sparkles.tv"), style: .plain, target: self, action: nil)
        let searchButton2 = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)

        searchButton1.tintColor = .white
        searchButton2.tintColor = .white

        let netflixLogo = UIBarButtonItem(image: UIImage(named: "single-large"), style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [searchButton2, searchButton1]
        navigationItem.leftBarButtonItem = netflixLogo
    }
    
    
}
