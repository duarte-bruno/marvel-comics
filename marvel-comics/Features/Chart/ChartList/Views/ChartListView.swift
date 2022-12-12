//
//  ChartListView.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import UIKit

class ChartListView: UIView {
    
    private let tableView: UITableView
    private var items: [ChartItem]
    
    // MARK: - Initialization
    
    init() {
        self.tableView = UITableView(frame: .zero, style: .plain)
        self.items = []
        super.init(frame: .zero)
        
        setupView()
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(Str.InitCoderNotImplemented.l())
    }
    
    // MARK: - Public methods
    
    func updateList(_ items: [ChartItem]) {
        self.items = items
        tableView.reloadData()
    }
    
    func removeItem(_ chartItem: ChartItem) {
        
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTableView() {
        tableView.register(ChartItemTableViewCell.self, forCellReuseIdentifier: ChartItemTableViewCell.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

extension ChartListView: UITableViewDelegate {
    
}

extension ChartListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ChartItemTableViewCell.cellIdentifier, for: indexPath) as? ChartItemTableViewCell else {
            return UITableViewCell(frame: .zero)
        }
        
        cell.setupCell(with: items[indexPath.row])
        return cell
    }
}
