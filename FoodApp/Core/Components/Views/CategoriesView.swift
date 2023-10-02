//
//  CategoriesView.swift
//  FoodApp
//
//  Created by Enes Sancar on 28.09.2023.
//

import UIKit
import SnapKit

final class CategoriesView: UIStackView {
    
    var collectionView: UICollectionView!
    private var titleLabel = UILabel(frame: .zero)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        configureTitleLabel()
        configureCollectionView()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    private func configureStackView() {
        axis = .vertical
        distribution = .fill
        //spacing = 5
    }
    
    private func configureTitleLabel() {
        addArrangedSubview(titleLabel)
        titleLabel.font = .boldSystemFont(ofSize: 26)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createCategoryFlowLayout())
        addArrangedSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.width / 2)
        }
    }
}
