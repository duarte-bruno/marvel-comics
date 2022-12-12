//
//  TotalCartValueView.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import UIKit

protocol TotalCartValueViewDelegate: AnyObject {
    func closeCart()
}

class TotalCartValueView: UIView {

    private let stackView: UIStackView
    private let totalLabel: UILabel
    private let purchaseButton: UIButton
    private weak var delegate: TotalCartValueViewDelegate?
    
    // MARK: - Initialization
    
    init(delegate: TotalCartValueViewDelegate?) {
        self.delegate = delegate
        stackView = UIStackView()
        totalLabel = UILabel()
        purchaseButton = UIButton()
        super.init(frame: .zero)
        
        setupView()
        setupStackView()
        setupTotalLabel()
        setupPurchaseButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(Str.InitCoderNotImplemented.l())
    }
    
    // MARK: - Public methods
    
    func updateTotal(items: [ChartItem]) {
        var price = 0.0
        for item in items {
            price += item.price.price
        }
        
        totalLabel.text = "U$\(String(format: "%.2f", price))"
        setButtonEnabled(price > 0)
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
    }
    
    private func setupTotalLabel() {
        totalLabel.text = "U$0.0"
        totalLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        totalLabel.tintColor = .black
        totalLabel.textAlignment = .left
        totalLabel.numberOfLines = 1
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(totalLabel)
    }
    
    private func setupPurchaseButton() {
        purchaseButton.setTitle("Close cart", for: .normal)
        purchaseButton.backgroundColor = .darkGray
        purchaseButton.tintColor = .white
        purchaseButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        purchaseButton.layer.cornerRadius = 4
        purchaseButton.addTarget(self, action: #selector(buyNowTap), for: .touchUpInside)
        purchaseButton.isEnabled = false
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(purchaseButton)
    }
    
    private func setButtonEnabled(_ enabled: Bool) {
        if enabled {
            purchaseButton.backgroundColor = .red
            purchaseButton.isEnabled = true
        } else {
            purchaseButton.backgroundColor = .darkGray
            purchaseButton.isEnabled = false
        }
    }
    
    @objc private func buyNowTap(sender: UIButton?) {
        setButtonEnabled(false)
        delegate?.closeCart()
    }
}
