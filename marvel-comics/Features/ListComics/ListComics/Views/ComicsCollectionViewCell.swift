//
//  ComicsCollectionViewCell.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 11/12/22.
//

import UIKit

class ComicsCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "ComicsCollectionViewCell"
    
    private let label = UILabel()
    private let image = CustomImageView()
    private var comic: Comic?

    // MARK: - Public methods

    func setupCell(with comic: Comic) {
        self.comic = comic
        setupLabel()
        setupImage()
    }
    
    // MARK: - Private methods
    
    private func setupLabel() {
        guard let comic = comic else { return }
        
        label.text = comic.title
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupImage() {
        guard let comic = comic else { return }
        
        image.loadImageUsing(comic.thumbnail.thumbUrl(size: .portrait_uncanny))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            image.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -8)
        ])
    }
}
