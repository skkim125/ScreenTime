//
//  TabbarViewController.swift
//  ScreenTimes
//
//  Created by 최대성 on 10/11/24.
//


import UIKit

final class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        
        
    }
    
    private func setTabBar() {
        let trendVC = UINavigationController(rootViewController: TrendViewController())

        let searchVC = UINavigationController(rootViewController: DownloadViewController())
        
        trendVC.tabBarItem = UITabBarItem(title: "세팅", image: UIImage(systemName: "gearshape"), tag: 0)

        searchVC.tabBarItem = UITabBarItem(title: "세팅", image: UIImage(systemName: "gearshape"), tag: 1)
        
        setViewControllers([trendVC, searchVC], animated: true)
        tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .black
        
        let tabbarSet = UITabBarAppearance()
        tabbarSet.backgroundColor = .lightGray.withAlphaComponent(0.2)
        tabbarSet.backgroundEffect = nil
        
        tabBar.standardAppearance = tabbarSet
        
        self.selectedIndex = 0
    }
}
