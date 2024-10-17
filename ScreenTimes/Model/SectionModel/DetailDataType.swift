//
//  DetailDataType.swift
//  ScreenTimes
//
//  Created by 김상규 on 10/11/24.
//

import Foundation
import RxDataSources

enum DetailDataType {
    case movieDetail(items: [DetailItem])
    case similar(items: [DetailItem])
}

extension DetailDataType: SectionModelType {
    typealias Item = DetailItem
    
    var items: [DetailItem] {
        switch self {
        case .movieDetail(items: let items):
            return items.map { $0 }
        case .similar(items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: DetailDataType, items: [Item]) {
        switch original {
        case .movieDetail(items: let items):
            self = .movieDetail(items: items)
        case .similar(items: let items):
            self = .similar(items: items)
        }
    }
}

enum DetailItem {
    case movieDetail(item: MediaDetail)
    case similar(item: Detail)
}
