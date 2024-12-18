//
//  DetailVM.swift
//  ScreenTimes
//
//  Created by 김상규 on 10/12/24.
//

import Foundation
import RxSwift
import RxCocoa

struct MediaDetail {
    let movie: Detail
    let cast: [CastResult]
    let crew: [CrewResult]
    let similar: [Detail]
}

final class DetailVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let selectedMovie: PublishSubject<Detail?>
    }
    
    struct Output {
        let movieDetail: BehaviorSubject<[DetailDataType]>
    }
    
    func transform(_ input: Input) -> Output {
        let inputSelectedMovie = PublishSubject<Detail>()
        let movieCast = PublishSubject<Cast>()
        let similarMovies = PublishSubject<[Detail]>()
        let movieDetail = BehaviorSubject<[DetailDataType]>(value: [])
        
        input.selectedMovie
            .bind(with: self) { owner, value in
                guard let movie = value else { return }
                inputSelectedMovie.onNext(movie)
            }
            .disposed(by: disposeBag)
        
        inputSelectedMovie
            .bind(with: self) { owner, movie in
                var mediaType = ""
                
                if movie.media_type.isEmpty {
                    mediaType = "movie"
                } else {
                    mediaType = movie.media_type
                }
                
                NetworkManager.request(router: mediaType == "movie" ? .castMovie(id: movie.id) : .castTV(id: movie.id), model: Cast.self)
                    .subscribe { value in
                        guard let value = value else { return }
                        
                        var castArray: [CastResult] = []
                        var crewArray: [CrewResult] = []
                        
                        if value.cast.isEmpty {
                            castArray = []
                        } else if value.cast.count < 3 {
                            for i in value.cast.startIndex...value.cast.endIndex-1 {
                                castArray.append(value.cast[i])
                            }
                        } else {
                            for i in 0...2 {
                                castArray.append(value.cast[i])
                            }
                        }
                        
                        if value.crew.isEmpty {
                            crewArray = []
                        }  else if value.crew.count < 3 {
                            for i in value.crew.startIndex...value.crew.endIndex-1 {
                                crewArray.append(value.crew[i])
                            }
                        } else {
                            for i in 0...2 {
                                crewArray.append(value.crew[i])
                            }
                        }
                        
                        movieCast.onNext(Cast(id: movie.id, cast: castArray, crew: crewArray))
                        
                    } onFailure: { error in
                        print(error)
                    }
                    .disposed(by: owner.disposeBag)
                
                switch mediaType {
                case "movie":
                    NetworkManager.request(router: .similarMovie(id: movie.id), model: Movie.self)
                        .subscribe { movies in
                            guard let movies = movies else { return }
                            let similars = movies.results.map({
                                return Detail(backdrop_path: $0.backdrop_path, id: $0.id, name: $0.title, overview: $0.overview, poster_path: $0.poster_path, media_type: $0.media_type ?? "", genre_ids: $0.genre_ids, vote_average: $0.vote_average)
                            })
                            
                            similarMovies.onNext(similars)
                        } onFailure: { error in
                            print(error)
                        }
                        .disposed(by: owner.disposeBag)
                default:
                    NetworkManager.request(router: .similarTV(id: movie.id), model: TV.self)
                        .subscribe { movies in
                            guard let movies = movies else { return }
                            let similars = movies.results.map({
                                return Detail(backdrop_path: $0.backdrop_path, id: $0.id, name: $0.name, overview: $0.overview, poster_path: $0.poster_path, media_type: $0.media_type ?? "", genre_ids: $0.genre_ids, vote_average: $0.vote_average)
                            })
                            
                            similarMovies.onNext(similars)
                        } onFailure: { error in
                            print(error)
                        }
                        .disposed(by: owner.disposeBag)
                }
            }
            .disposed(by: disposeBag)
     

        Observable.zip(inputSelectedMovie, movieCast, similarMovies)
            .map { (movie, cast, similars) -> [DetailDataType] in
                let movieDetail = MediaDetail(movie: movie, cast: cast.cast, crew: cast.crew, similar: similars)

                let convertArray = [DetailItem.movieDetail(item: movieDetail)]
                let convertSimilar = movieDetail.similar.map({ DetailItem.similar(item: $0)
                })
                let convertSimilarArray = DetailDataType.similar(items: convertSimilar)
                
                return [DetailDataType.movieDetail(items: convertArray), convertSimilarArray]
            }
            .bind(to: movieDetail)
            .disposed(by: disposeBag)
     
        return Output(movieDetail: movieDetail)
    }
    
}
