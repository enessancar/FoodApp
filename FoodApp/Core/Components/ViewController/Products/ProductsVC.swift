//
//  ProductsVC.swift
//  FoodApp
//
//  Created by Enes Sancar on 29.09.2023.
//

import UIKit
import SnapKit

protocol ProductsVCDelegate: AnyObject {
    func loadingStatusChanged(_ status: LoadingStatus)
    func productSelected(_ product: ProductData)
}

final class ProductsVC: UIViewController {
    
    private let viewModel: ProductsViewModel
    private var collectionView: UICollectionView!
    private weak var delegate: ProductsVCDelegate!
    
    init(service: ProductService, delegate: ProductsVCDelegate) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    private func addBinder() {
        viewModel.products.bind { [weak self] returnedProducts in
            guard let self else { return }
            
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
        }
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createProductFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identfier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - CollectionView
extension ProductsVC: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.products.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identfier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.products.value[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
}
