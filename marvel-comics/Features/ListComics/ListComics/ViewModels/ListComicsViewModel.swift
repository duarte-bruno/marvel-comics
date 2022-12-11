//
//  ListComicsViewModel.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 10/12/22.
//

import Foundation

protocol ListComicsViewModelCoordinatorDelegate: AnyObject {
    func showComicDetail(_ comic: Comic)
}

protocol ListComicsViewModelDelegate: AnyObject {
    func comicsResultUpdated()
    func showErrorAlert(title: String, message: String)
}

protocol ListComicsViewModelProtocol {
    var delegate: ListComicsViewModelDelegate? { get set }
    var title: String { get }
    var comicsResult: ComicsResult? { get }
    
    init(service: ListComicsServiceProtocol, coordinatorDelegate: ListComicsViewModelCoordinatorDelegate?)
    
    func updateComicsResult()
    func showComicDetail(_ comic: Comic)
}

class ListComicsViewModel: ListComicsViewModelProtocol {

    weak var delegate: ListComicsViewModelDelegate?
    var comicsResult: ComicsResult?
    let title: String
    
    private weak var coordinatorDelegate: ListComicsViewModelCoordinatorDelegate?
    private let service: ListComicsServiceProtocol
    
    required init(service: ListComicsServiceProtocol, coordinatorDelegate: ListComicsViewModelCoordinatorDelegate?) {
        self.service = service
        self.coordinatorDelegate = coordinatorDelegate
        self.comicsResult = nil
        self.title = Str.TransportErrorTitle.l()
    }
    
    func updateComicsResult() {
        service.getComics { [weak self] result in
            switch result {
            case.success(let result):
                self?.comicsResult = result
                self?.delegate?.comicsResultUpdated()
            case .failure(let error):
                print(error.description)
                switch error {
                case .transportError:
                    self?.delegate?.showErrorAlert(title: Str.TransportErrorTitle.l(), message: Str.TransportErrorMessage.l())
                default:
                    self?.delegate?.showErrorAlert(title: Str.SystemErrorTitle.l(), message: Str.SystemErrorMessage.l())
                }
            }
        }
    }
    
    func showComicDetail(_ comic: Comic) {
        coordinatorDelegate?.showComicDetail(comic)
    }
}
