//
//  TabBarViewController.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 08/12/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    let listComicsCoordinator = ListComicsCoordinator()
    let chartCoordinator = ChartCoordinator()
    
    // MARK: - Object lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Setup

    private func setup() {
        
        let listComicsItem = UITabBarItem(
            title: listComicsCoordinator.title,
            image: UIImage(systemName: "books.vertical"),
            selectedImage: UIImage(systemName: "books.vertical"))
        listComicsCoordinator.navigationController.tabBarItem = listComicsItem
        
        let chartItem = UITabBarItem(
            title: chartCoordinator.title,
            image: UIImage(systemName: "cart"),
            selectedImage: UIImage(systemName: "cart"))
        chartCoordinator.navigationController.tabBarItem = chartItem

        self.viewControllers = [listComicsCoordinator.navigationController, chartCoordinator.navigationController]
        self.selectedViewController = listComicsCoordinator.navigationController
        self.selectedIndex = 0
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = .black
    }
}
