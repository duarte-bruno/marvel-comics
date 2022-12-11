//
//  ListComicsViewController.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 09/12/22.
//

import UIKit

class ListComicsViewController: UIViewController {
    
    private var viewModel: ListComicsViewModelProtocol
    
    init(viewModel: ListComicsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        title = viewModel.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.updateComicsResult()
    }
}

extension ListComicsViewController: ListComicsViewModelDelegate {
    func comicsResultUpdated() {
        print(viewModel.comicsResult?.data.count ?? "")
    }
    
    func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                print(action)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
