//
//  TabBarViewController.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 08/12/22.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Initialization
    
    init(controllers: [UIViewController], selected: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        setup(controllers, selected)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Str.InitCoderNotImplemented.l())
    }
    
    // MARK: - Private methods

    private func setup(_ controllers: [UIViewController], _ selected: UIViewController) {
        
//        let listComicsItem = UITabBarItem(
//            title: listComicsCoordinator.title,
//            image: UIImage(systemName: "books.vertical"),
//            selectedImage: UIImage(systemName: "books.vertical"))
//        listComicsCoordinator.navigationController.tabBarItem = listComicsItem
//
//        let chartItem = UITabBarItem(
//            title: chartCoordinator.title,
//            image: UIImage(systemName: "cart"),
//            selectedImage: UIImage(systemName: "cart"))
//        chartCoordinator.navigationController.tabBarItem = chartItem

        self.viewControllers = controllers
        self.selectedViewController = selected
        self.selectedIndex = 0
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = .black
    }
}
