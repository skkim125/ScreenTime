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
    
    var movie: MovieResult?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie = movie else { return }
        bind(movie: movie)
    }
    
    private func bind(movie: MovieResult) {
        let inputMovie = BehaviorSubject(value: movie)
        let movieCast = PublishSubject<Cast>()
        let movieG = PublishSubject<String>()
        let similarMovies = PublishSubject<[MovieResult]>()
        let movieDetail = PublishSubject<[DetailDataType]>()
        
        inputMovie.onNext(movie)
        
        inputMovie
            .bind(with: self) { owner, movie in
                NetworkManager.request(router: .castMovie(id: movie.id), model: Cast.self)
                    .subscribe { value in
                        guard let value = value else { return }
                        
                        var castArray: [CastResult] = []
                        var crewArray: [CrewResult] = []
                        
                        for i in 0...2 {
                            castArray.append(value.cast[i])
                        }
                        
                        for i in 0...2 {
                            crewArray.append(value.crew[i])
                        }
                        
                        movieCast.onNext(Cast(id: movie.id, cast: castArray, crew: crewArray))
                        
                    } onFailure: { error in
                        print(error)
                    }
                    .disposed(by: owner.disposeBag)
                
                NetworkManager.request(router: .genreMovie, model: Genre.self)
                    .subscribe { value in
                        guard let value = value else { return }
                        guard let g = movie.genre_ids.first else { return }
                        
                        value.genres.forEach { genre in
                            if g == genre.id {
                                movieG.onNext(genre.name)
                            }
                        }
                        
                    } onFailure: { error in
                        print(error)
                    }
                    .disposed(by: owner.disposeBag)
                
                NetworkManager.request(router: .similarMovie(id: movie.id), model: Movie.self)
                    .subscribe { movies in
                        guard let movies = movies else { return }
                        similarMovies.onNext(movies.results)
                    } onFailure: { error in
                        print(error)
                    }
                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
        
        Observable.zip(movieCast, movieG, similarMovies)
            .debug("Zip")
            .map { (cast, genre, similars) -> [DetailDataType] in
                print("컴바인레이티스트")
                let movieDetail = MovieDetail(movie: movie, cast: cast.cast, crew: cast.crew, similar: similars)
                let convertArray = [DetailItem.movieDetail(item: movieDetail)]
                let convertSimilar = similars.map({ DetailItem.similar(item: $0) })
                let convertSimilarArray = DetailDataType.similar(items: convertSimilar)
                
                print("컴바인레이티스트")
                return [DetailDataType.movieDetail(items: convertArray), convertSimilarArray]
            }
            .bind(to: movieDetail)
            .disposed(by: disposeBag)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<DetailDataType> { _, collectionView, indexPath, item in
            
            switch item {
            case .movieDetail(item: let movie):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
                
                cell.configureCell(movie)
                print("셀1")
                print(movie.movie.title)
                
                return cell
                
            case .similar(item: let movie):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultCollectionViewCell.identifier, for: indexPath) as? DefaultCollectionViewCell else { return UICollectionViewCell() }
                
                cell.configureCell(.threeCell, movie: movie)
                print("셀2")
                print(movie.title)
                
                return cell
            }
            
        }
        
        movieDetail
            .bind(with: self) { owner, data in
                print(data.count)
            }
            .disposed(by: disposeBag)
        
        movieDetail
            .bind(to: detailView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
