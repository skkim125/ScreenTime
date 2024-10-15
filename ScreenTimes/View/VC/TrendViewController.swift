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
        
        let output = trendVM.transform(input)
        
        output.randomContent
            .bind(with: self) { [weak self] owner, image in
                guard let self else { return }
                trendView.configureImage(imageURL: image)
                print("ㅇㄹㅇㄹㅇㄹ", image)
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
                
                let data = Detail(backdrop_path: result.backdrop_path, id: result.id, name: result.title, overview: result.overview, poster_path: result.poster_path, media_type: result.media_type ?? "", genre_ids: result.genre_ids, vote_average: result.vote_average)
                
                let vc = DetailViewController()
                vc.media = data
                
                owner.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        trendView.tvcontentsCollectionView.rx.modelSelected(TVResult.self)
            .bind(with: self) { owner, result in
                
                let data = Detail(backdrop_path: result.backdrop_path, id: result.id, name: result.name, overview: result.overview, poster_path: result.poster_path, media_type: result.media_type ?? "", genre_ids: result.genre_ids, vote_average: result.vote_average)
                
                let vc = DetailViewController()
                vc.media = data
                
                owner.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.networkError
            .bind(with: self) { owner, _ in
                
                owner.networkError()
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
