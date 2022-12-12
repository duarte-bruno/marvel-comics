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
    func addItem(_ chartItem: ChartItem)
}

class ChartListViewModel: ChartListViewModelProtocol {
    
    weak var delegate: ChartListViewModelDelegate?
    let title: String
    var chartList: [ChartItem]
    
    required init() {
        self.title = Str.ChartListTitle.l()
        self.chartList = []
    }
    
    func closeChart() {
        
    }
    
    func removeItem(_ chartItem: ChartItem) {
        if let index = chartList.firstIndex(of: chartItem) {
            chartList.remove(at: index)
        }
        delegate?.chartListUpdated()
    }
    
    func addItem(_ chartItem: ChartItem) {
        self.chartList.append(chartItem)
        delegate?.chartListUpdated()
    }
}
