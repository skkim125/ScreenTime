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
import RealmSwift

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
    private let realmRepo = RealmRepository()
    
    var media: Detail?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        detailView.setPosterView(media)
        bind(media: media)
    }
    
    private func bind(media: Detail?) {
        let inputMovie = PublishSubject<Detail?>()
        let input = DetailVM.Input(selectedMovie: inputMovie)
        let output = detailVM.transform(input)
        
        inputMovie.onNext(media)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<DetailDataType> { _, collectionView, indexPath, item in
            
            switch item {
            case .movieDetail(item: let media):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
                
                cell.configureCell(media)
                cell.backgroundColor = .black
                
                cell.saveBtn.rx.tap
                    .bind(with: self) { owner, _ in
                        let saveTitle = Save(title: movie.movie.title)
                        owner.saveImageToDocument(image: owner.detailView.posterView.image ?? UIImage(), filename: "\(saveTitle.id)")
                        owner.realmRepo.addSave(saveTitle)
                        print("saveButton Clicked")
                    }
                    .disposed(by: cell.disposeBag)
                
                return cell
                
            case .similar(item: let media):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultCollectionViewCell.identifier, for: indexPath) as? DefaultCollectionViewCell else { return UICollectionViewCell() }
                
                cell.configureCell(.threeCell, media: media)
                
                return cell
            }
        }
        
        output.movieDetail
            .bind(to: detailView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
