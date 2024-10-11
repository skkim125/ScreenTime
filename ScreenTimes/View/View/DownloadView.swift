//
//  DownloadView.swift
//  ScreenTimes
//
//  Created by 김상규 on 10/10/24.
//

import UIKit
import SnapKit

final class DownloadView: BaseView {
    let searchController = UISearchController(searchResultsController: nil)
    var layoutType: CVType = .table
    lazy var collectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: defaultCollectionViewLayout(layoutType))
        cv.register(DefaultCollectionViewCell.self, forCellWithReuseIdentifier: DefaultCollectionViewCell.identifier)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .black
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
