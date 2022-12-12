//
//  ComicDetailViewController.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import UIKit

class ComicDetailViewController: UIViewController {

    private var viewModel: ComicDetailViewModelProtocol
    private let contentView: UIStackView
    
    // MARK: - Initialization
    
    init(viewModel: ComicDetailViewModelProtocol) {
        self.viewModel = viewModel
        self.contentView = UIStackView()
        super.init(nibName: nil, bundle: nil)
        
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
        
        setupScrollView()
        setupCover()
        setupLabels()
        setupButtons()
    }
    
    // MARK: - Private methods
    
    private func setupScrollView() {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.axis = .vertical
        contentView.spacing = 10
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
                
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setupCover() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let cover = CustomImageView()
        cover.loadImageUsing(viewModel.comic.thumbnail.thumbUrl(size: .portrait_uncanny))
        
        cover.contentMode = .scaleAspectFill
        cover.layer.cornerRadius = 4
        cover.clipsToBounds = true
        cover.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(cover)
        contentView.addArrangedSubview(containerView)
        
        NSLayoutConstraint.activate([
            cover.topAnchor.constraint(equalTo: containerView.topAnchor),
            cover.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            cover.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            cover.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            cover.heightAnchor.constraint(equalTo: cover.widthAnchor, multiplier: 1.5)
        ])
    }
    
    private func setupLabels() {
        let title = UILabel()
        
        title.text = viewModel.comic.title
        title.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        title.textAlignment = .left
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(title)
        
        let issue = UILabel()
        
        issue.text = "Issue: \(viewModel.comic.issueNumber)#"
        issue.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        issue.textAlignment = .left
        issue.numberOfLines = 0
        issue.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(issue)
        
        let pages = UILabel()
        
        pages.text = "Pages: \(viewModel.comic.pageCount)"
        pages.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        pages.textAlignment = .left
        pages.numberOfLines = 0
        pages.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(pages)
        
        if viewModel.comic.creators.items.count > 0 {
            let creators = UILabel()
            
            var text = "Creators:"
            for creator in viewModel.comic.creators.items {
                text += " \(creator.name) (\(creator.role)),"
            }
            text.remove(at: text.index(before: text.endIndex))
            
            creators.text = text
            creators.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            creators.textAlignment = .left
            creators.numberOfLines = 0
            creators.translatesAutoresizingMaskIntoConstraints = false
            contentView.addArrangedSubview(creators)
        }
        
        let description = UILabel()
        
        description.text = viewModel.comic.resultDescription
        description.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        description.textAlignment = .left
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(description)
    }
    
    private func setupButtons() {
        let prices = UILabel()
        
        prices.text = "Price"
        prices.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        prices.textAlignment = .left
        prices.numberOfLines = 0
        prices.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(prices)
        
        let buyNow = UILabel()
        
        buyNow.text = "Buy with 1 click"
        buyNow.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        buyNow.textAlignment = .left
        buyNow.numberOfLines = 0
        buyNow.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(buyNow)
        
        let buyNowStack = UIStackView()
        buyNowStack.translatesAutoresizingMaskIntoConstraints = false
        buyNowStack.axis = .horizontal
        buyNowStack.distribution = .fillEqually
        buyNowStack.spacing = 5
        contentView.addArrangedSubview(buyNowStack)
        
        for (index, price) in viewModel.comic.prices.enumerated() {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setTitle("U$\(price.price ) \(price.type.label())", for: .normal)
            button.backgroundColor = .red
            button.tintColor = .white
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            button.layer.cornerRadius = 4
            button.tag = index
            button.addTarget(self, action: #selector(buyNowTap), for: .touchUpInside)
            buyNowStack.addArrangedSubview(button)
        }
        
        let addChart = UILabel()
        
        addChart.text = "Add to chart"
        addChart.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        addChart.textAlignment = .left
        addChart.numberOfLines = 0
        addChart.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(addChart)
        
        let addChartStack = UIStackView()
        addChartStack.translatesAutoresizingMaskIntoConstraints = false
        addChartStack.axis = .horizontal
        addChartStack.distribution = .fillEqually
        addChartStack.spacing = 5
        contentView.addArrangedSubview(addChartStack)
        
        for (index, price) in viewModel.comic.prices.enumerated() {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setTitle("U$\(price.price ) \(price.type.label())", for: .normal)
            button.backgroundColor = .black
            button.tintColor = .white
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            button.layer.cornerRadius = 4
            button.tag = index
            button.addTarget(self, action: #selector(addToChartTap), for: .touchUpInside)
            addChartStack.addArrangedSubview(button)
        }
    }
    
    @objc func buyNowTap(sender: UIButton?) {
        viewModel.buyComic(viewModel.comic.prices[sender?.tag ?? 0])
    }
    
    @objc func addToChartTap(sender: UIButton?) {
        viewModel.addComicToChart(viewModel.comic.prices[sender?.tag ?? 0])
    }
}

extension ComicDetailViewController: ComicDetailViewModelDelegate {
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
