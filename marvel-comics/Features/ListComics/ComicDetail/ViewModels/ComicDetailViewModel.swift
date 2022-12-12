//
//  ComicDetailViewModel.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import Foundation

protocol ComicDetailViewModelCoordinatorDelegate: AnyObject {
    func buyComic(_ comic: Comic, _ price: Price)
    func addComicToChart(_ comic: Comic, _ price: Price)
}

protocol ComicDetailViewModelDelegate: AnyObject {
    func showErrorAlert(title: String, message: String)
}

protocol ComicDetailViewModelProtocol {
    var delegate: ComicDetailViewModelDelegate? { get set }
    var title: String { get }
    var comic: Comic { get }
    
    init(comic: Comic, coordinatorDelegate: ComicDetailViewModelCoordinatorDelegate?)
    
    func buyComic(_ price: Price)
    func addComicToChart(_ price: Price)
}

class ComicDetailViewModel: ComicDetailViewModelProtocol {
    
    weak var delegate: ComicDetailViewModelDelegate?
    var title: String
    var comic: Comic
    
    private let coordinatorDelegate: ComicDetailViewModelCoordinatorDelegate?
    
    required init(comic: Comic, coordinatorDelegate: ComicDetailViewModelCoordinatorDelegate?) {
        self.comic = comic
        self.coordinatorDelegate = coordinatorDelegate
        self.title = Str.ComicDetailTitle.l()
    }
    
    func buyComic(_ price: Price) {
        coordinatorDelegate?.buyComic(comic, price)
    }
    
    func addComicToChart(_ price: Price) {
        coordinatorDelegate?.addComicToChart(comic, price)
    }
}
