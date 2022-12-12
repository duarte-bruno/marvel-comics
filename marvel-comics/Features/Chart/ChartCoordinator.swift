//
//  ChartCoordinator.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import UIKit

class ChartCoordinator: Coordinator {
    
    private enum Screen {
        case chartList
    }
    
    let navigationController: UINavigationController
    
    var title: String {
        return Str.ChartListTitle.l()
    }
 
    init() {
        self.navigationController = UINavigationController()
        
        setupNavigation()
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
            let viewModel = ChartListViewModel()
            let controller = ChartListViewController(viewModel: viewModel)
            return controller
        }
    }
    
    private func showNext(screen: Screen) {
        navigationController.pushViewController(getScreen(screen), animated: true)
    }
}
