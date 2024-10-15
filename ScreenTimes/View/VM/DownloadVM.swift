//
//  DownloadVM.swift
//  ScreenTimes
//

//

import Foundation
import RxSwift
import RxCocoa

final class DownloadVM {
    
    struct Input {
        let trigger: Observable<Void>
        let deleteSavedContent: PublishSubject<IndexPath>
    }
    
    struct Output {
        let savedList: BehaviorSubject<[Save]>
    }
    
    private let realmRepo = RealmRepository()
    private let disposeBag = DisposeBag()
    
    private let triggerSubject = PublishSubject<Void>()
    
    @objc private func handleNewMediaNotification() {
        triggerSubject.onNext(())
    }
    
    func transform(_ input: Input) -> Output {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNewMediaNotification), name: NSNotification.Name(rawValue: "newmedia"), object: nil)
        
        let savedList = BehaviorSubject(value: [Save(mediaId: 0, title: "")])
        
        // zip -- X, combinelatest -- X, merge -- 0
        Observable.merge(input.trigger, triggerSubject)
            .bind(with: self) { owner, _ in
                let list = owner.realmRepo.fetchSavedList()
                savedList.onNext(list)
            }
            .disposed(by: disposeBag)
        
        
        input.deleteSavedContent
            .bind(with: self) { owner, indexPath in
                var currentList = try! savedList.value()
                let saveToDelete = currentList[indexPath.row]
                
                owner.realmRepo.removeImageFromDocument(filename: "\(saveToDelete.id)")
                owner.realmRepo.deleteSave(saveToDelete)
                
                currentList.remove(at: indexPath.row)
                savedList.onNext(currentList)
            }
            .disposed(by: disposeBag)
        
        return Output(savedList: savedList)
    }
}
