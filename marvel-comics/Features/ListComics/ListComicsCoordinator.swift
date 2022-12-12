//
//  ListComicsCoordinator.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 10/12/22.
//

import UIKit

protocol ListComicsCoordinatorDelegate: AnyObject {
    func buyComic(_ comic: Comic, _ price: Price)
    func addComicToChart(_ comic: Comic, _ price: Price)
}

class ListComicsCoordinator: Coordinator {
    
    var initialController: UIViewController {
        return navigationController
    }
    
    private enum Screen {
        case listComics
        case comicDetail(_ comic: Comic)
    }
    
    private let navigationController: UINavigationController
    private let httpRequest: HttpRequest
    private weak var delegate: ListComicsCoordinatorDelegate?
    
    var title: String {
        return Str.ListComicsTitle.l()
    }
    
    // MARK: - Initialization
    
    init(delegate: ListComicsCoordinatorDelegate?) {
        self.navigationController = UINavigationController()
        self.httpRequest = UrlSessionRequest(ProdAppConfig.shared)
        self.delegate = delegate
        
        setupTabBarItem()
        setupNavigation()
    }
    
    // MARK: - Private methods
    
    private func setupTabBarItem() {
        let listComicsItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: "person.2.crop.square.stack"),
            selectedImage: UIImage(systemName: "person.2.crop.square.stack.fill"))
        navigationController.tabBarItem = listComicsItem
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
        case .comicDetail(let comic):
            let viewModel = ComicDetailViewModel(comic: comic, coordinatorDelegate: self)
            let controller = ComicDetailViewController(viewModel: viewModel)
            return controller
        }
    }
    
    private func showNext(screen: Screen) {
        navigationController.pushViewController(getScreen(screen), animated: true)
    }
}
                                                    
extension ListComicsCoordinator: ListComicsViewModelCoordinatorDelegate {
    func showComicDetail(_ comic: Comic) {
        showNext(screen: .comicDetail(comic))
    }
}

extension ListComicsCoordinator: ComicDetailViewModelCoordinatorDelegate {
    func buyComic(_ comic: Comic, _ price: Price) {
        delegate?.buyComic(comic, price)
    }
    
    func addComicToChart(_ comic: Comic, _ price: Price) {
        delegate?.addComicToChart(comic, price)
    }
}
