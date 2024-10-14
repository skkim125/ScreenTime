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
                    .flatMap { [weak self] _ -> Observable<Void> in
                        guard let self = self else { return .empty() }
                        let mediaId = media.movie.id
                        
                        if self.realmRepo.isExistSave(mediaId: mediaId) {
                            return self.showCustomAlert(message: "이미 저장된 미디어예요 :)")
                        } else {
                            let saveTitle = Save(mediaId: mediaId, title: media.movie.name)
                            self.saveImageToDocument(image: self.detailView.posterView.image ?? UIImage(), filename: "\(saveTitle.id)")
                            self.realmRepo.addSave(saveTitle)
                            return self.showCustomAlert(message: "미디어를 저장하였습니다 :)")
                        }
                    }
                    .subscribe(onNext: {
                        print("Alert confirm Button Clicked")
                    })
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
