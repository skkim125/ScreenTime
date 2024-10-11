//
//  UIView+.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/8/24.
//

import UIKit

extension UIView: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
    func defaultCollectionViewLayout(_ type: CVType) -> UICollectionViewCompositionalLayout {
        
        switch type {
        case .threeCell:
            return threeCellCollectionViewLayout()
        case .table:
            return tableCollectionViewLayout()
        }
    }
    
    private func threeCellCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(220))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func tableCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfiguration.showsSeparators = false
        
        let insetValue: CGFloat = 15
        
        listConfiguration.separatorConfiguration.topSeparatorVisibility = .hidden
        listConfiguration.separatorConfiguration.bottomSeparatorInsets = .init(top: 0, leading: insetValue, bottom: 0, trailing: insetValue)
        
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        
        return layout
    }
}

enum CVType {
    case threeCell
    case table
}
