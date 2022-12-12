//
//  ChartListViewModel.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import Foundation

protocol ChartListViewModelDelegate: AnyObject {
    func chartListUpdated()
}

protocol ChartListViewModelProtocol {
    var delegate: ChartListViewModelDelegate? { get set }
    var title: String { get }
    var chartList: [ChartItem] { get }
    
    init()
    
    func closeChart()
    func removeItem(_ chartItem: ChartItem)
    func addComicToChart(_ comic: Comic, _ price: Price)
}

class ChartListViewModel: ChartListViewModelProtocol {
    
    weak var delegate: ChartListViewModelDelegate?
    let title: String
    var chartList: [ChartItem]
    
    // MARK: - Initialization
    
    required init() {
        self.title = Str.ChartListTitle.l()
        self.chartList = []
    }
    
    // MARK: - Public methods
    
    func closeChart() {
        
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
}
