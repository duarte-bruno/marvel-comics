//
//  ListComicsViewController.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 09/12/22.
//

import UIKit

class ListComicsViewController: UIViewController {
    
    private var viewModel: ListComicsViewModelProtocol
    private var comicsListView: ComicsListView? = nil
    
    // MARK: - Initialization
    
    init(viewModel: ListComicsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.comicsListView = ComicsListView(delegate: self)
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
        
        setupComicsView()
        viewModel.updateComicsResult()
    }
    
    // MARK: - Private methods
    
    private func setupComicsView() {
        guard let comicsListView = comicsListView else { return }
        view.addSubview(comicsListView)
        
        NSLayoutConstraint.activate([
            comicsListView.leftAnchor.constraint(equalTo: view.leftAnchor),
            comicsListView.rightAnchor.constraint(equalTo: view.rightAnchor),
            comicsListView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            comicsListView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
}

extension ListComicsViewController: ListComicsViewModelDelegate {
    func comicsResultUpdated() {
        comicsListView?.updateComicsList(comics: viewModel.comicsResult?.data.results ?? [])
    }
    
    func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ListComicsViewController: ComicsListViewDelegate {
    func comicSelected(comic: Comic) {
        viewModel.showComicDetail(comic)
    }
    
    func refreshComicsListContent() {
        
    }
}
