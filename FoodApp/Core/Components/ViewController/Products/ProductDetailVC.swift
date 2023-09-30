//
//  ProductDetailVC.swift
//  FoodApp
//
//  Created by Enes Sancar on 29.09.2023.
//

import UIKit
import SnapKit


final class ProductDetailVC: UIViewController {
    
    private let scrollView = UIScrollView(frame: .zero)
    private let stackView  = UIStackView()
    
    private let productImageView = FCImageView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let descriptionLabel = UILabel(frame: .zero)
    
    private let attributesStackView = UIStackView(frame: .zero)
    private var sizeAttribute: AttributeView!
    private var caloriesAttribute: AttributeView!
    private var cookingAttribute: AttributeView!
    
    private var addCardView: AddCardView!
    
    private let product: ProductData!
    init(product: ProductData) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ProductDetailVC {
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

//MARK: - ScrollView, StackView
extension ProductDetailVC {
    private func configureScrollView() {
        view.addSubview(scrollView)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureStackView() {
        scrollView.addSubview(stackView)
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 10, bottom: 30, right: 10)
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
        }
    }
}

//MARK: - Product ImageView - Title Label
extension ProductDetailVC {
    private func configureProductImageView() {
        stackView.addArrangedSubview(productImageView)
        
        guard let urlString = product.images?.first?.use else { return }
        productImageView.download(urlString: urlString, renderingMode: .alwaysOriginal)
        
        productImageView.snp.makeConstraints { make in
            make.height.equalTo(stackView.snp.width).multipliedBy(0.8)
        }
    }
    
    private func configureTitleLabel() {
        stackView.addArrangedSubview(titleLabel)
        titleLabel.text = product.title
        titleLabel.font = .boldSystemFont(ofSize: 26)
    }
}

//MARK: - Attributes
extension ProductDetailVC {
    private func configureAttributeStackView() {
        stackView.addArrangedSubview(attributesStackView)
        stackView.setCustomSpacing(40, after: titleLabel)
        
        attributesStackView.axis = .horizontal
        attributesStackView.distribution = .fillEqually
        attributesStackView.spacing = 10
        
        attributesStackView.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
    }
    
    private func configureAttributes() {
        sizeAttribute = .init(headerText: "Size", bodyText: "Medium")
        attributesStackView.addArrangedSubview(sizeAttribute)
        
        caloriesAttribute = .init(headerText: "Calories", bodyText: "150 Kcal")
        attributesStackView.addArrangedSubview(caloriesAttribute)
        
        cookingAttribute = .init(headerText: "Cooking", bodyText: "10 - 15 min")
        attributesStackView.addArrangedSubview(cookingAttribute)
    }
}

//MARK: - DescriptionLabel
extension ProductDetailVC {
    private func configureDescriptionLabel() {
        view.addSubview(descriptionLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.setCustomSpacing(40, after: attributesStackView)
        
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.text = product.loremDescription
        descriptionLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 4
    }
}

extension ProductDetailVC: AddCardViewDelegate {
    private func configureCardContainerView() {
        addCardView = AddCardView(product: product, delegate: self)
        stackView.addArrangedSubview(addCardView)
        stackView.setCustomSpacing(40, after: descriptionLabel)
    }
    
    func addCardButtonAction() {
        
        navigationController?.popViewController(animated: true)
    }
}
