//
//  DownloadView.swift
//  ScreenTimes
//
//  Created by 김상규 on 10/10/24.
//

import UIKit
import SnapKit

final class DownloadView: BaseView {
    
    let tableView: UITableView = {
       let view = UITableView()
       view.allowsSelection = true
       view.backgroundColor = .clear
       view.separatorStyle = .none
       view.bounces = true
       view.showsVerticalScrollIndicator = true
       view.contentInset = .zero
       view.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.register(DownloadTableViewCell.self, forCellReuseIdentifier: DownloadTableViewCell.identifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
