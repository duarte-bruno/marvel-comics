//
//  ComicsListView.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 11/12/22.
//

import UIKit

protocol ComicsListViewDelegate: AnyObject {
    func refreshComicsListContent()
    func comicSelected(comic: Comic)
}

class ComicsListView: UIView {
    
    private let collectionView: UICollectionView
    private weak var delegate: ComicsListViewDelegate?
    private var comics: [Comic]
    
    // MARK: - Initialization
    
    init(delegate: ComicsListViewDelegate?) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.delegate = delegate
        self.comics = []
        super.init(frame: .zero)
        
        setupView()
        setupCollectionView()
        setupRefreshControl()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(Str.InitCoderNotImplemented.l())
    }
    
    // MARK: - Public methods
    
    func updateComicsList(comics: [Comic]) {
        DispatchQueue.main.async { [weak self] in
            self?.comics = comics
            self?.collectionView.refreshControl?.endRefreshing()
            self?.collectionView.reloadData()
        }
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupCollectionView() {
        collectionView.register(ComicsCollectionViewCell.self, forCellWithReuseIdentifier: ComicsCollectionViewCell.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.collectionViewLayout = createCollectionLayout()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func createCollectionLayout() -> UICollectionViewLayout {
        let itemWidth = ((UIScreen.main.bounds.width - 10) / 3) - 12

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)

        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 15
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 42)
        
        return layout
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func refreshContent() {
        delegate?.refreshComicsListContent()
    }
}

// MARK: - UICollectionViewDelegate

extension ComicsListView: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension ComicsListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ComicsCollectionViewCell.cellIdentifier, for: indexPath) as? ComicsCollectionViewCell else {
            return UICollectionViewCell(frame: .zero)
        }
        
        cell.setupCell(with: comics[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.comicSelected(comic: comics[indexPath.row])
    }
}
