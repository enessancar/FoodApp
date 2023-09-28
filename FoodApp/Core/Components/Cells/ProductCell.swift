//
//  ProductCell.swift
//  FoodApp
//
//  Created by Enes Sancar on 27.09.2023.
//

import UIKit
import SnapKit

final class ProductCell: UICollectionViewCell {
    static let identfier = "ProductCell"
    
    //MARK: - Properties
    private var productImageView = FCImageView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let priceLabel = UILabel(frame: .zero)
    private let campaingPriceLabel = UILabel(frame: .zero)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        backgroundColor = .secondarySystemBackground
        
        configureProductImageView()
        configureTitleLabel()
        configurePriceLabel()
        configureCampaingPriceLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImageView.cancelDownloading()
        productImageView.image = nil
        
        titleLabel.text = nil
        
        priceLabel.strikeThrough(false)
        priceLabel.text = nil
        priceLabel.font = .boldSystemFont(ofSize: 20)
        priceLabel.textAlignment = .center
        
        campaingPriceLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with product: ProductData) {
        titleLabel.text = product.title
        priceLabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: product.price ?? 0))?.asTRYCurrency()
        
        guard let urlString = product.images?.first?.use else { return }
        productImageView.download(urlString: urlString, renderingMode: .alwaysOriginal)
        
        if let campaignPrice = product.campaignPrice {
            priceLabel.strikeThrough()
            priceLabel.font = .systemFont(ofSize: 16)
            priceLabel.textAlignment = .left
            
            campaingPriceLabel.alpha = 1
            campaingPriceLabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: campaignPrice))?.asTRYCurrency()
        }
    }
    
    private func configureProductImageView() {
        addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(productImageView.snp.width)
        }
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom)
            make.leading.trailing.equalTo(productImageView)
        }
    }
    
    private func configurePriceLabel() {
        addSubview(priceLabel)
        
        priceLabel.font = .boldSystemFont(ofSize: 20)
        priceLabel.textAlignment = .center
        priceLabel.textColor = .systemOrange
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(productImageView)
        }
    }
    
    private func configureCampaingPriceLabel() {
        addSubview(campaingPriceLabel)
        
        campaingPriceLabel.font = .boldSystemFont(ofSize: 24)
        campaingPriceLabel.textAlignment = .right
        campaingPriceLabel.textColor = .systemGreen
        campaingPriceLabel.alpha = 0
        
        campaingPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
