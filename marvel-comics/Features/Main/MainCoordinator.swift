//
//  MainCoordinator.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var initialController: UIViewController {
        return tabBarViewController ?? UIViewController()
    }
    
    private var tabBarViewController: TabBarViewController? = nil
    
    private var listComicsCoordinator: ListComicsCoordinator? = nil
    private var chartCoordinator: ChartCoordinator? = nil
    private var libraryCoordinator: LibraryCoordinator? = nil
    
    // MARK: - Initialization
    
    init() {
        setupCoordinators()
        setupTabBarController()
    }
    
    // MARK: - Private methods
    
    private func setupCoordinators() {
        self.listComicsCoordinator = ListComicsCoordinator(delegate: self)
        self.chartCoordinator = ChartCoordinator()
        self.libraryCoordinator = LibraryCoordinator()
    }
    
    private func setupTabBarController() {
        guard let listComicsCoordinator = listComicsCoordinator, let chartCoordinator = chartCoordinator, let libraryCoordinator = libraryCoordinator else { return }
        
        self.tabBarViewController = TabBarViewController(
            controllers: [listComicsCoordinator.initialController, chartCoordinator.initialController, libraryCoordinator.initialController],
            selected: listComicsCoordinator.initialController)
    }
}

// MARK: - ListComicsCoordinatorDelegate

extension MainCoordinator: ListComicsCoordinatorDelegate {
    func buyComic(_ comic: Comic, _ price: Price) {
        chartCoordinator?.buyComic(comic, price)
    }
    
    func addComicToChart(_ comic: Comic, _ price: Price) {
        chartCoordinator?.addComicToChart(comic, price)
    }
}
