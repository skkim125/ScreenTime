//
//  DefaultCollectionViewCell.swift
//  ScreenTimes
//
//  Created by 김상규 on 10/9/24.
//

import UIKit
import SnapKit

final class DefaultCollectionViewCell: UICollectionViewCell {
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let playButton = UIButton()
    
    init(_ type: CVType) {
        super.init(frame: .zero)
        
        configureHierarchy(type)
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
                make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            }
        case .table:
            posterImageView.snp.makeConstraints { make in
                make.leading.equalTo(contentView.snp.leading).offset(10)
                make.verticalEdges.equalTo(contentView.snp.verticalEdges).offset(10)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.leading.equalTo(posterImageView.snp.trailing).offset(5)
                make.height.equalTo(25)
            }
            
            playButton.snp.makeConstraints { make in
                make.trailing.equalTo(contentView.snp.trailing).offset(10)
                make.size.equalTo(50)
                make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            }
        }
    }
    
    func configureView() {
        posterImageView.image = UIImage(systemName: "star.fill")
        titleLabel.text = "안녕하세요"
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.backgroundColor = .gray
        playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
