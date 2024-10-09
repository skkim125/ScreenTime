//
//  DefaultCollectionViewCell.swift
//  ScreenTimes
//
//  Created by 김상규 on 10/9/24.
//

import UIKit
import SnapKit
import Kingfisher

final class DefaultCollectionViewCell: UICollectionViewCell {
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let playButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func configureHierarchy(_ type: CVType) {
        contentView.addSubview(posterImageView)
        
        switch type {
        case .threeCell:
            break
        case .table:
            contentView.addSubview(titleLabel)
            contentView.addSubview(playButton)
        }
    }
    
    func configureLayout(_ type: CVType) {
        switch type {
        case .threeCell:
            posterImageView.snp.makeConstraints { make in
                make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            }
        case .table:
            posterImageView.snp.makeConstraints { make in
                make.leading.equalTo(contentView.snp.leading).offset(10)
                make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(10)
                make.width.equalTo(150)
                make.height.equalTo(120)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.leading.equalTo(posterImageView.snp.trailing).offset(5)
                make.height.equalTo(25)
                make.centerY.equalTo(posterImageView.snp.centerY)
            }
            
            playButton.snp.makeConstraints { make in
                make.trailing.equalTo(contentView.snp.trailing).inset(10)
                make.size.equalTo(80)
                make.leading.equalTo(titleLabel.snp.trailing).offset(10)
                make.centerY.equalTo(titleLabel.snp.centerY)
            }
        }
    }
    
    func configureCell(_ type: CVType, movie: MovieResult) {
        configureHierarchy(type)
        configureLayout(type)
        
        contentView.backgroundColor = .black
        
        if let url = URL(string: "https://image.tmdb.org/t/p/original" + (movie.poster_path ?? "")) {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = UIImage(systemName: "photo")
        }
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
        
        titleLabel.text = movie.title
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular, scale: .large)
        playButton.setImage(UIImage(systemName: "play.circle", withConfiguration: imageConfig), for: .normal)
        playButton.imageView?.contentMode = .scaleAspectFit
        playButton.tintColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
