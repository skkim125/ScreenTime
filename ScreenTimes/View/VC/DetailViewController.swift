//
//  DetailView.swift
//  ScreenTimes
//
//  Created by 최대성 on 10/11/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


struct MovieDetail {
    let movie: MovieResult
    let cast: [CastResult]
    let crew: [CrewResult]
    let similar: [MovieResult]
}

final class DetailViewController: BaseViewController {
    
    private let detailView = DetailView()
    private var disposeBag = DisposeBag()
    private let detailVM = DetailVM()
    
    var movie: MovieResult?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        detailView.setPosterView(movie)
        bind(movie: movie)
    }
    
    private func bind(movie: MovieResult?) {
        let inputMovie = PublishSubject<MovieResult?>()
        let input = DetailVM.Input(selectedMovie: inputMovie)
        let output = detailVM.transform(input)
        
        inputMovie.onNext(movie)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<DetailDataType> { _, collectionView, indexPath, item in
            
            switch item {
            case .movieDetail(item: let movie):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
                
                cell.configureCell(movie)
                cell.backgroundColor = .black
                
                return cell
                
            case .similar(item: let movie):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultCollectionViewCell.identifier, for: indexPath) as? DefaultCollectionViewCell else { return UICollectionViewCell() }
                
                cell.configureCell(.threeCell, movie: movie)
                
                return cell
            }
        }
        
        output.movieDetail
            .bind(to: detailView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
