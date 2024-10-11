//
//  SearchView.swift
//  ScreenTimes
//
//  Created by 김상규 on 10/9/24.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
    let searchController = UISearchController(searchResultsController: nil)
    var layoutType: CVType = .table

    let infoLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    let emptyLabel = {
        let label = UILabel()
        label.text = "검색결과가 없습니다."
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.isHidden = true
        
        return label
    }()

    lazy var collectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: defaultCollectionViewLayout(layoutType))
        cv.register(DefaultCollectionViewCell.self, forCellWithReuseIdentifier: DefaultCollectionViewCell.identifier)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .black
        
        return cv
    }()
    
    init(frame: CGRect, type: CVType) {
        super.init(frame: frame)
        layoutType = type
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func configureHierarchy() {
        addSubview(infoLabel)
        addSubview(collectionView)
        addSubview(emptyLabel)
    }
    
    override func configureLayout() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(15)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
}
