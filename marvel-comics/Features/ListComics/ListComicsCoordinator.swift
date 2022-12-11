//
//  ListComicsCoordinator.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 10/12/22.
//

import Foundation
import UIKit

class ListComicsCoordinator: Coordinator {
    
    private enum Screen {
        case listComics
    }
    
    let navigationController: UINavigationController
    private let httpRequest: HttpRequest
    
    init() {
        self.navigationController = UINavigationController()
        self.httpRequest = UrlSessionRequest(ProdAppConfig.shared)
        
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationController.viewControllers = [getScreen(.listComics)]
        navigationController.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        navigationController.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.tintColor = .black
    }
    
    private func getScreen(_ screen: Screen) -> UIViewController {
        switch screen {
        case .listComics:
            let service = ListComicsService(httpRequest)
            let viewModel = ListComicsViewModel(service: service, coordinatorDelegate: self)
            let controller = ListComicsViewController(viewModel: viewModel)
            return controller
        }
    }
    
    private func showNext(screen: Screen) {
        navigationController.pushViewController(getScreen(screen), animated: true)
    }
}
                                                    
extension ListComicsCoordinator: ListComicsViewModelCoordinatorDelegate {
    func showComicDetail(_ comic: Comic) {
        showNext(screen: .listComics)
    }
}
