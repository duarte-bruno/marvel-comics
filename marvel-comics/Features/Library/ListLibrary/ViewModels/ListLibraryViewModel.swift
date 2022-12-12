//
//  ListLibraryViewModel.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import Foundation

protocol ListLibraryViewModelCoordinatorDelegate: AnyObject {
    func showComicDetail(_ comic: Comic)
}

protocol ListLibraryViewModelDelegate: AnyObject {
    func showErrorAlert(title: String, message: String)
    func comicsListUpdated()
}

protocol ListLibraryViewModelProtocol {
    var delegate: ListLibraryViewModelDelegate? { get set }
    var title: String { get }
    var comics: [Comic]? { get }
    
    init(service: CartServiceProtocol, coordinatorDelegate: ListLibraryViewModelCoordinatorDelegate?)
    
    func updateComicsList()
    func showComicDetail(_ comic: Comic)
}

class ListLibraryViewModel: ListLibraryViewModelProtocol {

    weak var delegate: ListLibraryViewModelDelegate?
    var comics: [Comic]?
    let title: String
    
    private weak var coordinatorDelegate: ListLibraryViewModelCoordinatorDelegate?
    private let service: CartServiceProtocol
    
    required init(service: CartServiceProtocol, coordinatorDelegate: ListLibraryViewModelCoordinatorDelegate?) {
        self.service = service
        self.coordinatorDelegate = coordinatorDelegate
        self.comics = []
        self.title = Str.ListLibraryTitle.l()
    }
    
    func updateComicsList() {
        service.getCartPurchases { [weak self] result in
            switch result {
            case .success(let comics):
                self?.comics = comics
                self?.delegate?.comicsListUpdated()
            case .failure:
                self?.delegate?.showErrorAlert(title: Str.SystemErrorTitle.l(), message: Str.SystemErrorMessage.l())
            }
        }
    }
    
    func showComicDetail(_ comic: Comic) {
        coordinatorDelegate?.showComicDetail(comic)
    }
}
