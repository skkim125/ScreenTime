//
//  CustomAlertView.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/13/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CustomAlertView: UIView {
    
    private let disposeBag = DisposeBag()
    private let tapEvent = PublishSubject<Void>()
    
    private let backgroundView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let messageLabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let confirmButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTapEvent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .black.withAlphaComponent(0.3)
        
        addSubview(backgroundView)
        backgroundView.addSubview(messageLabel)
        backgroundView.addSubview(confirmButton)
        
        backgroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(120)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalTo(messageLabel).inset(16)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        confirmButton.backgroundColor = .systemRed
    }
    
    private func setupTapEvent() {
        confirmButton.rx.tap
            .do(onNext: { [weak self] in
                self?.removeFromSuperview()
            })
            .bind(to: tapEvent)
            .disposed(by: disposeBag)
    }
    
    func configure(message: String) -> Observable<Void> {
        messageLabel.text = message
        return tapEvent.asObservable()
    }
}
