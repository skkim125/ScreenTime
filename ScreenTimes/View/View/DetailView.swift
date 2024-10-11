//
//  DetailView.swift
//  ScreenTimes
//
//  Created by 최대성 on 10/11/24.
//

import UIKit
import SnapKit


final class DetailView: BaseView {
    
    private let posterView = {
        let view = UIImageView()
        view.backgroundColor = .yellow
        
        return view
    }()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
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
        label.numberOfLines = 0 
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
    
    private let temp = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(posterView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(rateLabel)
        contentView.addSubview(playBtn)
        contentView.addSubview(saveBtn)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(creditLabel)
        contentView.addSubview(similarContentLabel)
        contentView.addSubview(temp)
    }
    
    override func configureLayout() {
        
        posterView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(250)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(posterView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(15)
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
        creditLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        similarContentLabel.snp.makeConstraints { make in
            make.top.equalTo(creditLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        temp.snp.makeConstraints { make in
            make.top.equalTo(similarContentLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(800)
            make.bottom.equalTo(contentView.snp.bottom).inset(20)
        }
    }
    
    
}
