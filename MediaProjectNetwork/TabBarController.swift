//
//  TabBarController.swift
//  MediaProjectNetwork
//
//  Created by Jaka on 2024-06-30.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .white
        
        let trendPage = TrendingMediaView()
        let nav1 = UINavigationController(rootViewController: trendPage)
        nav1.tabBarItem = UITabBarItem(title: "New", image: UIImage(systemName: "popcorn.fill"), tag: 0)
        
        let searchPage = SearchViewController()
        let nav2 = UINavigationController(rootViewController: searchPage)
        nav2.tabBarItem = UITabBarItem(title: "Find", image: UIImage(systemName: "magnifyingglass.circle.fill"), tag: 1)
        
        setViewControllers([nav1, nav2], animated: true)
    }
}
