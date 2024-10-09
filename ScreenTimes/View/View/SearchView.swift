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
    
    lazy var collectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: defaultCollectionViewLayout(.table))
        cv.register(DefaultCollectionViewCell.self, forCellWithReuseIdentifier: DefaultCollectionViewCell.identifier)
        
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
}
