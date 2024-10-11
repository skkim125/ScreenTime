//
//  DetailView.swift
//  ScreenTimes
//
//  Created by 최대성 on 10/11/24.
//

import Foundation


final class DetailViewController: BaseViewController {
    
    private let detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
