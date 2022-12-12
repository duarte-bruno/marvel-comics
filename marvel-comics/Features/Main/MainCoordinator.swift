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
    
    // MARK: - Initialization
    
    init() {
        setupCoordinators()
        setupTabBarController()
    }
    
    // MARK: - Private methods
    
    private func setupCoordinators() {
        self.listComicsCoordinator = ListComicsCoordinator()
        self.chartCoordinator = ChartCoordinator()
    }
    
    private func setupTabBarController() {
        guard let listComicsCoordinator = listComicsCoordinator, let chartCoordinator = chartCoordinator else { return }
        
        self.tabBarViewController = TabBarViewController(
            controllers: [listComicsCoordinator.initialController, chartCoordinator.initialController],
            selected: listComicsCoordinator.initialController)
    }
}
