//
//  ChartListViewModel.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import Foundation

protocol ChartListViewModelDelegate: AnyObject {
    func chartListUpdated()
    func showErrorAlert(title: String, message: String)
}

protocol ChartListViewModelProtocol {
    var delegate: ChartListViewModelDelegate? { get set }
    var title: String { get }
    var chartList: [ChartItem] { get }
    
    init(service: CartServiceProtocol)
    
    func closeChart()
    func removeItem(_ chartItem: ChartItem)
    func addComicToChart(_ comic: Comic, _ price: Price)
}

class ChartListViewModel: ChartListViewModelProtocol {
    
    weak var delegate: ChartListViewModelDelegate?
    let title: String
    var chartList: [ChartItem]
    
    private let service: CartServiceProtocol
    
    // MARK: - Initialization
    
    required init(service: CartServiceProtocol) {
        self.title = Str.ChartListTitle.l()
        self.chartList = []
        self.service = service
    }
    
    // MARK: - Public methods
    
    func closeChart() {
        service.getCartPurchases { [weak self] result in
            switch result {
            case .success(let comics):
                self?.updatePurchases(with: comics)
            case .failure:
                self?.delegate?.showErrorAlert(title: Str.SystemErrorTitle.l(), message: Str.SystemErrorMessage.l())
            }
        }
    }
    
    func removeItem(_ chartItem: ChartItem) {
        if let index = chartList.firstIndex(of: chartItem) {
            chartList.remove(at: index)
        }
        delegate?.chartListUpdated()
    }
    
    func addComicToChart(_ comic: Comic, _ price: Price) {
        self.chartList.append(ChartItem(comic: comic, price: price))
        delegate?.chartListUpdated()
    }
    
    // MARK: - Private methods
    
    private func updatePurchases(with data: [Comic]?) {
        var newList: [Comic] = []
        
        for item in chartList {
            newList.append(item.comic)
        }
        
        if let data = data {
            newList.append(contentsOf: data)
        }
        
        service.postCartPurchases(data: newList) { [weak self] result in
            switch result {
            case .success:
                self?.chartList = []
                self?.delegate?.chartListUpdated()
                self?.delegate?.showErrorAlert(title: Str.BoughtTitle.l(), message: Str.BoughtMessage.l())
            case .failure:
                self?.delegate?.showErrorAlert(title: Str.SystemErrorTitle.l(), message: Str.SystemErrorMessage.l())
            }
        }
    }
}
