//
//  ChartItemTableViewCell.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import UIKit

class ChartItemTableViewCell: UITableViewCell {

    static let cellIdentifier = "ChartItemTableViewCell"
    
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let image = CustomImageView()
    private var item: ChartItem?
    
    // MARK: - Public methods
    
    func setupCell(with item: ChartItem) {
        self.item = item
        contentView.backgroundColor = .white
        setupImage()
        setupLabels()
    }
    
    // MARK: - Private methods
    
    private func setupImage() {
        guard let item = item else { return }
        
        image.loadImageUsing(item.comic.thumbnail.thumbUrl(size: .standard_fantastic))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 4
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            image.heightAnchor.constraint(equalToConstant: 70),
            image.widthAnchor.constraint(equalTo: image.heightAnchor)
        ])
    }
    
    private func setupLabels() {
        guard let item = item else { return }
        
        priceLabel.text = "\(item.price.type.label()) U$\(item.price.price)"
        priceLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        priceLabel.tintColor = .red
        priceLabel.textAlignment = .left
        priceLabel.numberOfLines = 1
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            priceLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 8),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 8),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
        
        titleLabel.text = item.comic.title
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 6),
            titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
