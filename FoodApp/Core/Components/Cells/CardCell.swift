//
//  CardCell.swift
//  FoodApp
//
//  Created by Enes Sancar on 27.09.2023.
//

import UIKit
import SnapKit

final class CardCell: UITableViewCell {
    static let identifier = "CardCell"
    
    //MARK: - Properties
    private let productImageView = FCImageView(frame: .zero)
    private let productTitleLabel = UILabel(frame: .zero)
    private let productDescriptionLabel = UILabel(frame: .zero)
    private let productPriceLabel = UILabel(frame: .zero)
    private let productCampaignPricelabel = UILabel(frame: .zero)
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureProductImageView()
        configureProductTitleLabel()
        configureProductDescriptionLabel()
        configureProductPriceLabel()
        configureProductCampaignPriceLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImageView.cancelDownloading()
        productImageView.image = nil
        
        productTitleLabel.text = nil
        productCampaignPricelabel.text = nil
        
        productPriceLabel.strikeThrough(false)
        productPriceLabel.text = nil
        productPriceLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    public func configure(_ product: ProductData) {
        guard let urlString = product.images?.first?.use else { return }
        productImageView.download(urlString: urlString, renderingMode: .alwaysOriginal)
        
        productTitleLabel.text = product.title
        productDescriptionLabel.text = product.loremDescription
        productPriceLabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: product.price ?? 0))?.asTRYCurrency()
        
        if let campaignPrice = product.campaignPrice {
            productCampaignPricelabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: campaignPrice))?.asTRYCurrency()
            productPriceLabel.strikeThrough()
            productPriceLabel.font = .boldSystemFont(ofSize: 16)
        }
    }
    
    private func configureProductImageView() {
        addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
        }
    }
    
    private func configureProductTitleLabel() {
        addSubview(productTitleLabel)
        productTitleLabel.font = .boldSystemFont(ofSize: 20)
        
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.top)
            make.leading.equalTo(productImageView.snp.trailing)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func configureProductDescriptionLabel() {
        addSubview(productDescriptionLabel)
        
        productDescriptionLabel.font = .systemFont(ofSize: 16)
        productDescriptionLabel.numberOfLines = 1
        productDescriptionLabel.tintColor = .secondaryLabel
        
        productDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(productImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    private func configureProductPriceLabel() {
        addSubview(productPriceLabel)
        
        productPriceLabel.font = .boldSystemFont(ofSize: 20)
        productPriceLabel.textColor = .systemOrange
        
        productPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(productDescriptionLabel.snp.bottom).offset(5)
            make.leading.equalTo(productImageView.snp.trailing).offset(10)
            make.width.equalTo(55)
        }
    }
    
    private func configureProductCampaignPriceLabel() {
        addSubview(productCampaignPricelabel)
        
        productCampaignPricelabel.font = .boldSystemFont(ofSize: 20)
        productCampaignPricelabel.textColor = .systemGreen
        
        productCampaignPricelabel.snp.makeConstraints { make in
            make.top.equalTo(productDescriptionLabel.snp.bottom).offset(5)
            make.leading.equalTo(productPriceLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
