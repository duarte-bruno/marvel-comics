//
//  TabBarViewController.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 08/12/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - Object lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let listComicsItem = UITabBarItem(
            title: "Comics",
            image: UIImage(systemName: "books.vertical"),
            selectedImage: UIImage(systemName: "books.vertical"))
        
        let listComicsCoordinator = ListComicsCoordinator()
        listComicsCoordinator.navigationController.tabBarItem = listComicsItem
        
        let listComicsItem2 = UITabBarItem(
            title: "Comics 2",
            image: UIImage(systemName: "books.vertical"),
            selectedImage: UIImage(systemName: "books.vertical"))
        
        let listComicsCoordinator2 = ListComicsCoordinator()
        listComicsCoordinator2.navigationController.tabBarItem = listComicsItem2

        self.viewControllers = [listComicsCoordinator.navigationController, listComicsCoordinator2.navigationController]
        self.selectedViewController = listComicsCoordinator.navigationController
        self.selectedIndex = 0
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = .black
    }
}
