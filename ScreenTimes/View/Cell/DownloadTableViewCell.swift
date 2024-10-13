//
//  DownloadTableViewCell.swift
//  ScreenTimes
//
//  Created by 최대성 on 10/13/24.
//

import UIKit
import SnapKit

final class DownloadTableViewCell: UITableViewCell {
    
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let playButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
    }
    func configureLayout() {
        posterImageView.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(10)
            make.width.equalTo(140)
            make.height.equalTo(120)
        }
        
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.height.equalTo(25)
            make.centerY.equalTo(posterImageView.snp.centerY)
        }
        
        playButton.snp.remakeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).inset(10)
            make.size.equalTo(60)
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    func configureCell(title: String?, id: String?) {
        if let id = id {
            print(id)
            posterImageView.image = RealmRepository().loadImageToDocument(filename: id)
        }
        
        titleLabel.text = title
    }
}
