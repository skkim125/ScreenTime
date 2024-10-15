//
//  DownloadViewController.swift
//  ScreenTimes
//
//  Created by 김상규 on 10/10/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RealmSwift

struct SavedContents {
    
    typealias Model = SectionModel<Section, Item>
    
    enum Section: Equatable {
        case contentType
    }
    enum Item: Equatable {
        case content(title: String?, id:ObjectId)
    }
}

final class DownloadViewController: BaseViewController {
    
    private let downloadView = DownloadView()
    private let disposeBag = DisposeBag()
    let downloadVM = DownloadVM()
    
    private var items = BehaviorSubject<[SavedContents.Model]>(value: [])

    
    override func loadView() {
        view = downloadView
        view.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureNavigationBar() {
        navigationItem.title = "다운로드 리스트"
    }
    
    override func bind() {
        print("짜잔")
        
        let deleteComponents = PublishSubject<IndexPath>()
        
        let input = DownloadVM.Input(trigger: Observable.just(()), deleteSavedContent: deleteComponents )
        
        let output = downloadVM.transform(input)
        
        output.savedList
            .map({ savedContents in
                
                let content = [
                    SavedContents.Model(
                        model: .contentType,
                        items: savedContents.map {SavedContents.Model.Item.content(title: $0.title, id: $0.id)
                        }
                    )
                ]
                return content
            })
            .bind(to: items)
            .disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SavedContents.Model> { dataSource, tableView, indexPath, item in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DownloadTableViewCell.identifier, for: indexPath) as? DownloadTableViewCell else { return UITableViewCell() }
            
            switch item {
            case let .content(title, id):
               
                cell.configureCell(title: title, id: "\(id)")
                
            }
            return cell
        }
        
        items
            .distinctUntilChanged()
            .bind(to: downloadView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        downloadView.tableView.rx.itemDeleted
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, indexPath in
                deleteComponents.onNext(indexPath)
            }
            .disposed(by: disposeBag)
    }
}
