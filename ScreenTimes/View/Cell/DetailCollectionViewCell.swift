//
//  DetailCollectionViewCell.swift
//  ScreenTimes
//
//  Created by 최대성 on 10/11/24.
//

import UIKit
import SnapKit
import RxSwift

final class DetailCollectionViewCell: UICollectionViewCell {
    
    let disposeBag = DisposeBag()
 
    private let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
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
    let saveBtn = {
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
        label.numberOfLines = 0
        return label
    }()
    private let castLabel = {
        let label = UILabel()
        label.text = "Dfdf\ndfdfdfdsf"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    private let crewLabel = {
        let label = UILabel()
        label.text = "Dfdf\ndfdfdfdsf"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        label.numberOfLines = 1
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
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(rateLabel)
        contentView.addSubview(playBtn)
        contentView.addSubview(saveBtn)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(castLabel)
        contentView.addSubview(crewLabel)
        contentView.addSubview(similarContentLabel)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        playBtn.snp.makeConstraints { make in
            make.top.equalTo(rateLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        saveBtn.snp.makeConstraints { make in
            make.top.equalTo(playBtn.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(saveBtn.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        castLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        crewLabel.snp.makeConstraints { make in
            make.top.equalTo(castLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        similarContentLabel.snp.makeConstraints { make in
            make.top.equalTo(crewLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
    }
    
    func configureCell(_ item: MediaDetail) {
        titleLabel.text = item.movie.name
        rateLabel.text = String(format: "%.2f", item.movie.vote_average)
        descriptionLabel.text = item.movie.overview
        var castString = ""
        var crewString = ""
        
        for cast in item.cast {
            castString += "\(cast.name) "
        }
        
        if !item.crew.isEmpty {
            for crew in item.crew {
                crewString += "\(crew.name) "
            }
        }
        castLabel.text = "출연: \(castString)"
        crewLabel.isHidden = item.crew.isEmpty ? true : false
        remakeLayout(crewLabel.isHidden)
        
        
        crewLabel.text = "크리에이터: \(crewString)"
        similarContentLabel.text = "비슷한 영화"
    }
    
    private func remakeLayout(_ isHidden: Bool) {
        if isHidden {
            similarContentLabel.snp.remakeConstraints { make in
                make.top.equalTo(castLabel.snp.bottom).offset(10)
                make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
                make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            }
        }
    }
}
