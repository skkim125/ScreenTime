//
//  TrendCollectionViewCell.swift
//  TMDBCollaborate
//
//  Created by 최대성 on 10/9/24.
//

import UIKit
import SnapKit
import RxSwift


final class TrendCollectionViewCell: UICollectionViewCell {
    
    private let imageView = {
        let view = UIImageView()
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let textlabel = {
        let text = UILabel()
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(textlabel)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        textlabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom).offset(-10)
        }
    }
    
    func configureCell(text: String) {
        textlabel.text = text
        
        
    }
    
}
