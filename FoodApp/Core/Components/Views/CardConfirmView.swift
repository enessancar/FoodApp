//
//  CardConfirmView.swift
//  FoodApp
//
//  Created by Enes Sancar on 28.09.2023.
//

import UIKit
import SnapKit

protocol CardConfirmCiewProtocol: AnyObject {
    func confirmButtonPressed()
}

final class CardConfirmView: UIStackView {
    
    private var priceStackView: UIStackView!
    private var priceTitleLabel = UILabel(frame: .zero)
    private var totalPriceLabel = UILabel(frame: .zero)
    
    private var confirmButton = UIButton(frame: .zero)
    
    private weak var delegate: CardConfirmCiewProtocol?
    
    init(delegate: CardConfirmCiewProtocol) {
        super.init(frame: .zero)
        self.delegate = delegate
        
        configureView()
        configurePriceStackView()
        configurePriceTitleLabel()
        configureTotalPriceLabel()
        configureConfirmButton()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPrice(totalPrice: Double) {
        self.totalPriceLabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: totalPrice))?.asTRYCurrency()
    }
    
    private func configureView() {
        layer.cornerRadius = 10
        backgroundColor = .systemGray6
        
        axis = .horizontal
        spacing = 40
        distribution = .fill
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    private func configurePriceStackView() {
        priceStackView = UIStackView(frame: .zero)
        addArrangedSubview(priceStackView)
        
        priceStackView.axis = .vertical
        priceStackView.spacing = 5
        priceStackView.distribution = .fill
    }
    
    private func configurePriceTitleLabel() {
        priceStackView.addArrangedSubview(priceTitleLabel)
        
        priceTitleLabel.text = "Total"
        priceTitleLabel.textColor = .secondaryLabel
        priceTitleLabel.font = .systemFont(ofSize: 18)
    }
    
    private func configureTotalPriceLabel() {
        priceStackView.addArrangedSubview(totalPriceLabel)
        totalPriceLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    private func configureConfirmButton() {
        addArrangedSubview(confirmButton)
        
        confirmButton.layer.cornerRadius = 10
        confirmButton.backgroundColor = .systemOrange
        
        confirmButton.setTitle("Confirm the Card", for: .normal)
        confirmButton.titleLabel?.font = .boldSystemFont(ofSize: 26)
        
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
    }
    
    @objc private func confirmButtonPressed() {
        delegate?.confirmButtonPressed()
    }
}

