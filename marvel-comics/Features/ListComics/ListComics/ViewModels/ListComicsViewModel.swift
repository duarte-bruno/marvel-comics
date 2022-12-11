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
        self.title = "Comics"
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
                    self?.delegate?.showErrorAlert(title: "Ops", message: "Ocorreu um erro de conexão, por favor verifique a sua conexão ou tente novamente mais tarde.")
                default:
                    self?.delegate?.showErrorAlert(title: "Ops", message: "Ocorreu um erro no sistema, por favor tente novamente mais tarde.")
                }
            }
        }
    }
    
    func showComicDetail(_ comic: Comic) {
        coordinatorDelegate?.showComicDetail(comic)
    }
}
