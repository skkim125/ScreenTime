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
        configureHierarchy()
        configureLayout()
        configureView()
    }
    func configureHierarchy() { }
    func configureLayout() { }
    func configureView() { }
}
