//
//  DownloadVM.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/13/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DownloadVM {
    
    private let realmRepo = RealmRepository()
    private let disposeBag = DisposeBag()
    
    struct Input {
        let downloadTrigger: Observable<Void>
    }
    
    struct Output {
        let savedMedia: BehaviorSubject<[Save]>
    }
    
    func transform(input: Input) -> Output {
        let savedMedia = BehaviorSubject(value: [Save(mediaId: 0, title: "")])
        
        input.downloadTrigger
            .bind(with: self) { owner, _ in
                let list = owner.realmRepo.fetchAllSaves()
                savedMedia.onNext(list)
            }
            .disposed(by: disposeBag)
        
        return Output(savedMedia: savedMedia)
    }
}
