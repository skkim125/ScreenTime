//
//  BaseViewController.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/8/24.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        bind()
        configureNavigationBar()
    }
    
    func bind() { }
    func configureNavigationBar() {
        
//        let navApp = UINavigationBarAppearance()
//        navApp.backgroundColor = .lightGray.withAlphaComponent(0.2)
//        navApp.backgroundEffect = nil
//        
//        navigationController?.navigationBar.standardAppearance = navApp
        
    }
}
