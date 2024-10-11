//
//  TrendViewController.swift
//  TMDBCollaborate
//
//  Created by 최대성 on 10/9/24.
//

import UIKit
import RxSwift
import RxCocoa

final class TrendViewController: BaseViewController {
    
    private let trendView = TrendView()
    private let list = BehaviorRelay(value: Array(1...10))
    private let disposeBag = DisposeBag()
    private let trendVM = TrendVM()
    
    override func loadView() {
        view = trendView
    }
    
    override func viewDidLoad() {
      
        bind()
        configureNavigationBar()
    }
    
    override func bind() {
        
        let input = TrendVM.Input(trendTrigger: Observable.just(()))
        
        let output = trendVM.transform(input: input)
        
        output.randomContent
            .bind(with: self) { [weak self] owner, image in
                guard let self else { return }
                trendView.configureImage(imageURL: image)
            }
            .disposed(by: disposeBag)
        
        output.trendMovieList
            .bind(to: trendView.moviecontentsCollectionView.rx.items(cellIdentifier: "TrendCollectionViewCell", cellType: TrendCollectionViewCell.self)) { (row, element, cell) in
                
                cell.configureCell(imageURL: element.poster_path ?? "")
            }
            .disposed(by: disposeBag)
        
        output.trendTVList
            .bind(to: trendView.tvcontentsCollectionView.rx.items(cellIdentifier: "TrendCollectionViewCell", cellType: TrendCollectionViewCell.self)) { (row, element, cell) in
                
                cell.configureCell(imageURL: element.poster_path ?? "")
            }
            .disposed(by: disposeBag)
        
        
        output.genre
            .bind(with: self) { owner, result in
                owner.trendView.genreLabel.text = result
            }
            .disposed(by: disposeBag)
        
        
        trendView.moviecontentsCollectionView.rx.modelSelected(MovieResult.self)
            .bind(with: self) { owner, result in
                let vc = DetailViewController()
                vc.movie = result
                
                owner.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        /*
         디테일뷰에 넘겨야할 요소
         - 이미지 패스
         - 제목 > name, title
         - rate
         - id
         
         */
        
        trendView.tvcontentsCollectionView.rx.modelSelected(TVResult.self)
            .bind(with: self) { owner, result in
                
                let vc = DetailViewController()
                
                owner.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
    override func configureNavigationBar() {
        
        
        let searchButton1 = UIBarButtonItem(image: UIImage(systemName: "sparkles.tv"), style: .plain, target: self, action: nil)
        let searchButton2 = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        
        searchButton1.tintColor = .white
        searchButton2.tintColor = .white
        
        let netflixLogo = UIBarButtonItem(image: UIImage(named: "single-large"), style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [searchButton2, searchButton1]
        navigationItem.leftBarButtonItem = netflixLogo
        
        let navApp = UINavigationBarAppearance()
        navApp.backgroundColor = .lightGray.withAlphaComponent(0.2)
        navApp.backgroundEffect = nil
        
        navigationController?.navigationBar.standardAppearance = navApp
    }
    
    
}
