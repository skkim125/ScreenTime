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
        titleLabel.isHidden = (type == .table) ? false : true
        playButton.isHidden = (type == .table) ? false : true
        
        switch type {
        case .threeCell:
            posterImageView.snp.makeConstraints { make in
                make.edges.equalTo(contentView.safeAreaLayoutGuide)
            }
        case .table:
            posterImageView.snp.makeConstraints { make in
                make.leading.equalTo(contentView.snp.leading).offset(10)
                make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(10)
                make.width.equalTo(140)
                make.height.equalTo(120)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.leading.equalTo(posterImageView.snp.trailing).offset(10)
                make.height.equalTo(25)
                make.centerY.equalTo(posterImageView.snp.centerY)
            }
            
            playButton.snp.makeConstraints { make in
                make.trailing.equalTo(contentView.snp.trailing).inset(10)
                make.size.equalTo(60)
                make.leading.equalTo(titleLabel.snp.trailing).offset(10)
                make.centerY.equalTo(titleLabel.snp.centerY)
            }
        }
    }
    
    func configureCell(_ type: CVType, media: Detail) {
        configureHierarchy(type)
        configureLayout(type)
        
        contentView.backgroundColor = .black
        
        setLayout(type)
        titleLabel.isHidden = (type == .table) ? false : true
        playButton.isHidden = (type == .table) ? false : true
        
        if let link = media.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/original" + link) {
            posterImageView.kf.setImage(with: url)
            posterImageView.contentMode = .scaleToFill
        } else {
            posterImageView.image = UIImage(systemName: "photo")
            posterImageView.tintColor = .white
        }
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
        
        titleLabel.text = media.name
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
    
    private func setLayout(_ type: CVType) {
        switch type {
        case .threeCell:
            posterImageView.snp.remakeConstraints { make in
                make.edges.equalTo(contentView.safeAreaLayoutGuide)
            }
        case .table:
            posterImageView.snp.remakeConstraints { make in
                make.leading.equalTo(contentView.snp.leading).offset(10)
                make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(10)
                make.width.equalTo(140)
                make.height.equalTo(120)
            }
            
            titleLabel.snp.remakeConstraints { make in
                make.leading.equalTo(posterImageView.snp.trailing).offset(10)
                make.height.equalTo(25)
                make.centerY.equalTo(posterImageView.snp.centerY)
            }
            
            playButton.snp.remakeConstraints { make in
                make.trailing.equalTo(contentView.snp.trailing).inset(10)
                make.size.equalTo(60)
                make.leading.equalTo(titleLabel.snp.trailing).offset(10)
                make.centerY.equalTo(titleLabel.snp.centerY)
            }
        }
    }
}
