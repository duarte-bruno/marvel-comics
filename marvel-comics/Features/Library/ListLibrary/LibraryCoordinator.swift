//
//  LibraryCoordinator.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import UIKit

class LibraryCoordinator: Coordinator {
    
    var initialController: UIViewController {
        return navigationController
    }
    
    private enum Screen {
        case listLibrary
        case comicDetail(_ comic: Comic)
    }
    
    private let navigationController: UINavigationController
    
    var title: String {
        return Str.ListLibraryTitle.l()
    }
    
    // MARK: - Initialization
    
    init() {
        self.navigationController = UINavigationController()
        
        setupTabBarItem()
        setupNavigation()
    }
    
    // MARK: - Private methods
    
    private func setupTabBarItem() {
        let listComicsItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: "books.vertical"),
            selectedImage: UIImage(systemName: "books.vertical.fill"))
        navigationController.tabBarItem = listComicsItem
    }
    
    private func setupNavigation() {
        navigationController.viewControllers = [getScreen(.listLibrary)]
        navigationController.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        navigationController.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.tintColor = .black
    }
    
    private func getScreen(_ screen: Screen) -> UIViewController {
        switch screen {
        case .listLibrary:
            let service = CartService(UserDefaultsDataStore())
            let viewModel = ListLibraryViewModel(service: service, coordinatorDelegate: self)
            let controller = ListLibraryViewController(viewModel: viewModel)
            return controller
        case .comicDetail(let comic):
            let viewModel = ComicDetailViewModel(comic: comic, coordinatorDelegate: nil)
            let controller = ComicDetailViewController(viewModel: viewModel)
            return controller
        }
    }
    
    private func showNext(screen: Screen) {
        navigationController.pushViewController(getScreen(screen), animated: true)
    }
}

extension LibraryCoordinator: ListLibraryViewModelCoordinatorDelegate {
    func showComicDetail(_ comic: Comic) {
        showNext(screen: .comicDetail(comic))
    }
}
