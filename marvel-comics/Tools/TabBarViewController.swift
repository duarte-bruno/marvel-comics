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
        let listComicsViewController = ListComicsViewController()
        listComicsViewController.tabBarItem = listComicsItem
        let listComicsNavigation = createNavigation(with: listComicsViewController)

        self.viewControllers = [listComicsNavigation]
        self.selectedViewController = listComicsNavigation
        self.selectedIndex = 0
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .darkGray
    }

    private func createNavigation(with viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigation.navigationBar.titleTextAttributes = textAttributes
        navigation.navigationBar.largeTitleTextAttributes = textAttributes
        navigation.navigationBar.barStyle = .default
        navigation.navigationBar.tintColor = .black

        return navigation
    }

}
