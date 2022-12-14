//
//  ChartCoordinator.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import UIKit

class ChartCoordinator: Coordinator {
    
    var initialController: UIViewController {
        return navigationController
    }
    
    private enum Screen {
        case chartList
    }
    
    private let navigationController: UINavigationController
    
    var title: String {
        return Str.ChartListTitle.l()
    }
    
    // MARK: - Initialization
 
    init() {
        self.navigationController = UINavigationController()
        
        setupTabBarItem()
        setupNavigation()
    }
    
    // MARK: - Public methods
    
    func buyComic(_ comic: Comic, _ price: Price) {
        guard let chartController = navigationController.viewControllers[0] as? ChartListViewController else { return }
        chartController.viewModel.buyComic(comic, price)
    }
    
    func addComicToChart(_ comic: Comic, _ price: Price) {
        guard let chartController = navigationController.viewControllers[0] as? ChartListViewController else { return }
        chartController.viewModel.addComicToChart(comic, price)
    }
    
    // MARK: - Private methods
    
    private func setupTabBarItem() {
        let listComicsItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: "cart"),
            selectedImage: UIImage(systemName: "cart.fill"))
        navigationController.tabBarItem = listComicsItem
    }
    
    private func setupNavigation() {
        navigationController.viewControllers = [getScreen(.chartList)]
        navigationController.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        navigationController.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.tintColor = .black
    }
    
    private func getScreen(_ screen: Screen) -> UIViewController {
        switch screen {
        case .chartList:
            let service = CartService(UserDefaultsDataStore())
            let viewModel = ChartListViewModel(service: service)
            let controller = ChartListViewController(viewModel: viewModel)
            return controller
        }
    }
    
    private func showNext(screen: Screen) {
        navigationController.pushViewController(getScreen(screen), animated: true)
    }
}
