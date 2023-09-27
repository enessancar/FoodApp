//
//  CategoryCell.swift
//  FoodApp
//
//  Created by Enes Sancar on 27.09.2023.
//

import UIKit
import SnapKit

final class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"
    
    private var categoryImageView: FCImageView!
    private let titleLabel = UILabel(frame: .zero)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        
        configureCategoryImageView()
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = .secondarySystemBackground
        
        titleLabel.text = nil
        categoryImageView.image = nil
        categoryImageView.cancelDownloading()
    }
    
    private func configureCategoryImageView() {
        categoryImageView = FCImageView(frame: .zero)
        addSubview(categoryImageView)
        
        categoryImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(categoryImageView.snp.width)
        }
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = .boldSystemFont(ofSize: 18)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(categoryImageView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(22)
        }
    }
    
    public func configure(_ categoryData: CategoryData) {
        titleLabel.text = categoryData.name ?? ""
        
        if let urlString = categoryData.icon {
            categoryImageView.download(urlString: urlString, renderingMode: .alwaysTemplate)
        }
    }
}
