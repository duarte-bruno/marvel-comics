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
    private var totalCartValueView: TotalCartValueView? = nil
    
    // MARK: - Initialization
    
    init(viewModel: ChartListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.chartListView = ChartListView()
        self.totalCartValueView = TotalCartValueView(delegate: self)
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
        
        setupTotalCartValueView()
        setupChartListView()
    }
    
    // MARK: - Private methods
    
    private func setupTotalCartValueView() {
        guard let totalCartValueView = totalCartValueView else { return }
        view.addSubview(totalCartValueView)
        
        NSLayoutConstraint.activate([
            totalCartValueView.leftAnchor.constraint(equalTo: view.leftAnchor),
            totalCartValueView.rightAnchor.constraint(equalTo: view.rightAnchor),
            totalCartValueView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    private func setupChartListView() {
        guard let chartListView = chartListView, let totalCartValueView = totalCartValueView else { return }
        view.addSubview(chartListView)
        
        NSLayoutConstraint.activate([
            chartListView.leftAnchor.constraint(equalTo: view.leftAnchor),
            chartListView.rightAnchor.constraint(equalTo: view.rightAnchor),
            chartListView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            chartListView.bottomAnchor.constraint(equalTo: totalCartValueView.topAnchor),
        ])
    }
}

extension ChartListViewController: ChartListViewModelDelegate {
    func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func chartListUpdated() {
        chartListView?.updateList(viewModel.chartList)
        totalCartValueView?.updateTotal(items: viewModel.chartList)
    }
}

extension ChartListViewController: TotalCartValueViewDelegate {
    func closeCart() {
        viewModel.closeChart()
    }
}
