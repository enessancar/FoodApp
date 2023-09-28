//
//  AddCardView.swift
//  FoodApp
//
//  Created by Enes Sancar on 28.09.2023.
//

import UIKit
import SnapKit

protocol AddCardViewDelegate: AnyObject {
    func addCardButtonAction()
}

final class AddCardView: UIView {
    
    private let beforeCampaingPriceLabel = UILabel(frame: .zero)
    private let priceLabel = UILabel(frame: .zero)
    private let addToCartButton = UIButton(frame: .zero)
    
    private let product: ProductData!
    private weak var delegate: AddCardViewDelegate!
    
    init(product: ProductData!, delegate: AddCardViewDelegate!) {
        self.product = product
        self.delegate = delegate
        super.init(frame: .zero)
        
        layer.cornerRadius = 10
        backgroundColor = .systemGray6.withAlphaComponent(0.6)
        heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configurePriceLabel() {
        addSubview(priceLabel)
        
        priceLabel.font = .boldSystemFont(ofSize: 32)
        priceLabel.textColor = .systemOrange
        
        if let campaignPrice = product.campaignPrice {
            priceLabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: campaignPrice))?.asTRYCurrency()
            priceLabel.textColor = .systemGreen
            
            
        } else {
            priceLabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: product.price ?? 0))?.asTRYCurrency()
        }
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
        }
    }
    
    private func configureAddCardButon() {
        addSubview(addToCartButton)
        
        addToCartButton.layer.cornerRadius = 10
        addToCartButton.setTitle("Add to Card", for: .normal)
        addToCartButton.titleLabel?.font = .boldSystemFont(ofSize: 26)
        addToCartButton.backgroundColor = .systemOrange
        addToCartButton.addTarget(self, action: #selector(addCardButtonAction), for: .touchUpInside)
        
        addToCartButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(priceLabel.snp.trailing).offset(20)
            make.trailing.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func configureBeforeCampaignPriceLabel() {
        addSubview(beforeCampaingPriceLabel)
        
        beforeCampaingPriceLabel.textColor = .systemOrange
        beforeCampaingPriceLabel.font = .systemFont(ofSize: 18)
        beforeCampaingPriceLabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: product.price ?? 0))?.asTRYCurrency()
        beforeCampaingPriceLabel.strikeThrough()
        
        beforeCampaingPriceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(80)
        }
    }
    
    @objc private func addCardButtonAction() {
        delegate.addCardButtonAction()
    }
}
