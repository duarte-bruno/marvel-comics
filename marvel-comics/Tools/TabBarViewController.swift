//
//  TabBarViewController.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 08/12/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    let listComicsCoordinator = ListComicsCoordinator()
    let listComicsCoordinator2 = ListComicsCoordinator()
    
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
        
        let listComicsItem2 = UITabBarItem(
            title: listComicsCoordinator2.title,
            image: UIImage(systemName: "books.vertical"),
            selectedImage: UIImage(systemName: "books.vertical"))
        listComicsCoordinator2.navigationController.tabBarItem = listComicsItem2

        self.viewControllers = [listComicsCoordinator.navigationController, listComicsCoordinator2.navigationController]
        self.selectedViewController = listComicsCoordinator.navigationController
        self.selectedIndex = 0
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = .black
    }
}
