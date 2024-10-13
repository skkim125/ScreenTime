//
//  DetailVM.swift
//  ScreenTimes
//
//  Created by 김상규 on 10/12/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailVM {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let selectedMovie: PublishSubject<MovieResult?>
    }
    
    struct Output {
        let movieDetail: BehaviorSubject<[DetailDataType]>
    }
    
    func transform(_ input: Input) -> Output {
        let inputSelectedMovie = PublishSubject<MovieResult>()
        let movieCast = PublishSubject<Cast>()
        let movieG = PublishSubject<String>()
        let similarMovies = PublishSubject<[MovieResult]>()
        let movieDetail = BehaviorSubject<[DetailDataType]>(value: [])
        
        input.selectedMovie
            .bind(with: self) { owner, value in
                guard let movie = value else { return }
                inputSelectedMovie.onNext(movie)
            }
            .disposed(by: disposeBag)
        
        inputSelectedMovie
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
     
        Observable.zip(inputSelectedMovie, movieCast, movieG, similarMovies)
            .map { (movie, cast, genre, similars) -> [DetailDataType] in
                let movieDetail = MovieDetail(movie: movie, cast: cast.cast, crew: cast.crew, similar: similars)
                let convertArray = [DetailItem.movieDetail(item: movieDetail)]
                let convertSimilar = similars.map({ DetailItem.similar(item: $0) })
                let convertSimilarArray = DetailDataType.similar(items: convertSimilar)
                
                return [DetailDataType.movieDetail(items: convertArray), convertSimilarArray]
            }
            .bind(to: movieDetail)
            .disposed(by: disposeBag)
     
        return Output(movieDetail: movieDetail)
    }
    
}
