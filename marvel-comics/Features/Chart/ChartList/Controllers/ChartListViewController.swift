//
//  ChartListViewController.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import UIKit

class ChartListViewController: UIViewController {
    
    var viewModel: ChartListViewModelProtocol
    private var chartListView: ChartListView? = nil
    
    // MARK: - Initialization
    
    init(viewModel: ChartListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.chartListView = ChartListView()
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError(Str.InitCoderNotImplemented.l())
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        title = viewModel.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChartListView()
    }
    
    // MARK: - Private methods
    
    private func setupChartListView() {
        guard let chartListView = chartListView else { return }
        view.addSubview(chartListView)
        
        NSLayoutConstraint.activate([
            chartListView.leftAnchor.constraint(equalTo: view.leftAnchor),
            chartListView.rightAnchor.constraint(equalTo: view.rightAnchor),
            chartListView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            chartListView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
}

extension ChartListViewController: ChartListViewModelDelegate {
    func chartListUpdated() {
        chartListView?.updateList(viewModel.chartList)
    }
}
