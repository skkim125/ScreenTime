//
//  TabbarViewController.swift
//  ScreenTimes
//
//  Created by 최대성 on 10/11/24.
//


import UIKit
import RxSwift

final class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    private func setTabBar() {
        let trendVC = UINavigationController(rootViewController: TrendViewController())

        let searchVC = UINavigationController(rootViewController: SearchViewController())
        
        let downloadVC = UINavigationController(rootViewController: DownloadViewController())
        
        trendVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        searchVC.tabBarItem = UITabBarItem(title: "Top Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        downloadVC.tabBarItem = UITabBarItem(title: "Download", image: UIImage(systemName: "face.smiling"), tag: 2)
        
        setViewControllers([trendVC, searchVC, downloadVC], animated: true)
        
        tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .black
        
        let tabbarSet = UITabBarAppearance()
        tabbarSet.backgroundColor = .lightGray.withAlphaComponent(0.2)
        tabbarSet.backgroundEffect = nil
        
        tabBar.standardAppearance = tabbarSet
        
        self.selectedIndex = 0
    }
}
