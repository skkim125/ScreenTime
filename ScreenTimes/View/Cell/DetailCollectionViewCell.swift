//
//  DetailCollectionViewCell.swift
//  ScreenTimes
//
//  Created by 최대성 on 10/11/24.
//

import UIKit
import SnapKit

final class DetailCollectionViewCell: UICollectionViewCell {
 
    private let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "예비 제목"
        label.textColor = .white
        return label
    }()
    private let rateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "예비 등급"
        label.textColor = .white
        return label
    }()
    private let playBtn = {
        let btn = UIButton()
        var config = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.boldSystemFont(ofSize: 12)

        config.attributedTitle = AttributedString("재생", attributes: titleContainer)
        config.baseForegroundColor = .black
        config.image = UIImage(systemName: "play.fill")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 15)
        config.imagePadding = 8
        config.cornerStyle = .medium
        
        btn.configuration = config
        
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        return btn
    }()
    private let saveBtn = {
        let btn = UIButton()
        var config = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.boldSystemFont(ofSize: 12)

        config.attributedTitle = AttributedString("저장", attributes: titleContainer)
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "square.and.arrow.down")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 15)
        config.imagePadding = 8
        config.cornerStyle = .medium
        
        btn.configuration = config
        
        btn.backgroundColor = .darkGray
        btn.layer.cornerRadius = 5
        
        return btn
    }()
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "001010101010101011010101010100110"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    private let creditLabel = {
        let label = UILabel()
        label.text = "Dfdf\ndfdfdfdsf"
        label.textColor = .lightGray
        label.numberOfLines = 0 // 줄바꿈을 허용
        label.textAlignment = .left
        return label
    }()
    private let similarContentLabel = {
        let label = UILabel()
        label.text = "비슷한 컨텐츠"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(rateLabel)
        contentView.addSubview(playBtn)
        contentView.addSubview(saveBtn)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(creditLabel)
        contentView.addSubview(similarContentLabel)
    }
    
    
}
