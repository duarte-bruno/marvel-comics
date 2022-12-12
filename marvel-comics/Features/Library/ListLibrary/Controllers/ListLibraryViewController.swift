//
//  ListLibraryViewController.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import UIKit

class ListLibraryViewController: UIViewController {

    private var viewModel: ListLibraryViewModelProtocol
    private var comicsListView: ComicsListView? = nil
    
    // MARK: - Initialization
    
    init(viewModel: ListLibraryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.comicsListView = ComicsListView(delegate: self)
        self.viewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.updateComicsList()
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
        viewModel.updateComicsList()
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

extension ListLibraryViewController: ListLibraryViewModelDelegate {
    func comicsListUpdated() {
        comicsListView?.updateComicsList(comics: viewModel.comics ?? [])
    }
    
    func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ListLibraryViewController: ComicsListViewDelegate {
    func comicSelected(comic: Comic) {
        viewModel.showComicDetail(comic)
    }
    
    func refreshComicsListContent() {
        
    }
}
