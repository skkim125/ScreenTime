//
//  DetailView.swift
//  ScreenTimes
//
//  Created by 최대성 on 10/11/24.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailView: BaseView {
    
    let posterView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrow.clockwise")
        
        return view
    }()
    
    lazy var collectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: myPageCollectionView())
        cv.register(DefaultCollectionViewCell.self, forCellWithReuseIdentifier: DefaultCollectionViewCell.identifier)
        cv.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .black
        
        return cv
    }()
    
    override func configureHierarchy() {
        addSubview(posterView)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        
        posterView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(250)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(posterView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
    
    func setPosterView(_ movie: MovieResult?) {
        guard let movie = movie, let poster = movie.backdrop_path , let url = URL(string: "https://image.tmdb.org/t/p/original" + poster) else { return }
        
        posterView.kf.setImage(with: url)
    }
}
