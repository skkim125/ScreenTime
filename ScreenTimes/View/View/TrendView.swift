//
//  TrendView.swift
//  TMDBCollaborate
//
//  Created by 최대성 on 10/9/24.
//

import UIKit
import SnapKit

final class TrendView: UIView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let deviceWidth = UIScreen.main.bounds.width
    
    private let recView = {
        let view = UIView()
        view.backgroundColor = .systemBrown
        view.layer.cornerRadius = 10
        return view
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
    private let plusBtn = {
        let btn = UIButton()
        var config = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.boldSystemFont(ofSize: 12)

        config.attributedTitle = AttributedString("내가 찜한 리스트", attributes: titleContainer)
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "plus")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 15)
        config.imagePadding = 8
        config.cornerStyle = .medium
        
        btn.configuration = config
        
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 5
        
        return btn
    }()
    private let genreLabel = {
        let label = UILabel()
        label.text = "예비 장르 레이블"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let categoryLabel1 = {
       let label = UILabel()
        label.text = "지금 뜨는 영화"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
   
    let maincontentsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: maincontentsViewLayout())
    
    let tvcontentsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: maincontentsViewLayout())
    
    private static func maincontentsViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let cellSpacing: CGFloat = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 110, height: 140)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: cellSpacing, right: cellSpacing)
        return layout
    }
    
    private let categoryLabel2 =  {
        let label = UILabel()
        label.text = "지금 뜨는 TV시리즈"   
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureHierarchy()
        configureLayout()
        maincontentsCollectionView.register(TrendCollectionViewCell.self, forCellWithReuseIdentifier: "TrendCollectionViewCell")
        tvcontentsCollectionView.register(TrendCollectionViewCell.self, forCellWithReuseIdentifier: "TrendCollectionViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(recView)
        contentView.addSubview(playBtn)
        contentView.addSubview(plusBtn)
        contentView.addSubview(genreLabel)
        contentView.addSubview(categoryLabel1)
        contentView.addSubview(maincontentsCollectionView)
        contentView.addSubview(categoryLabel2)
        contentView.addSubview(tvcontentsCollectionView)
        maincontentsCollectionView.showsHorizontalScrollIndicator = false
        tvcontentsCollectionView.showsHorizontalScrollIndicator = false
        maincontentsCollectionView.backgroundColor = .clear
        tvcontentsCollectionView.backgroundColor = .clear
    }
    
    private func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
        recView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(450)
        }
         playBtn.snp.makeConstraints { make in
             make.bottom.equalTo(recView.snp.bottom).inset(10)
             make.leading.equalTo(recView.snp.leading).inset(20)
             make.width.equalTo((deviceWidth - 40)/2 - 20)
             make.height.equalTo(30)
         }
        plusBtn.snp.makeConstraints { make in
            make.bottom.equalTo(recView.snp.bottom).inset(10)
            make.trailing.equalTo(recView.snp.trailing).inset(20)
            make.width.equalTo((deviceWidth - 20)/2 - 20)
            make.height.equalTo(30)
        }
        genreLabel.snp.makeConstraints { make in
            make.bottom.equalTo(plusBtn.snp.top).offset(-10)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        categoryLabel1.snp.makeConstraints { make in
            make.top.equalTo(recView.snp.bottom).offset(30)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        maincontentsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel1.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(150)
        }
        categoryLabel2.snp.makeConstraints { make in
            make.top.equalTo(maincontentsCollectionView.snp.bottom).offset(20)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        tvcontentsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel2.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(150)
            make.bottom.equalTo(contentView.snp.bottom).inset(20)
        }
    }
    
}
