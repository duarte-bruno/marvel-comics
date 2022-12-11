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

        self.viewControllers = [listComicsCoordinator.navigationController]
        self.selectedViewController = listComicsCoordinator.navigationController
        self.selectedIndex = 0
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .darkGray
    }
}
