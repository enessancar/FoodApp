//
//  HomeScreen.swift
//  FoodApp
//
//  Created by Enes Sancar on 29.09.2023.
//

import UIKit
import SnapKit

final class HomeScreen: DataLoadingVC {
    
    private let viewModel: HomeViewModel
    
    private let scrollView = UIScrollView(frame: .zero)
    private let stackView  = UIStackView()
    private var categoriesView: CategoriesView!
    
    private var productView = UIView(frame: .zero)
    private var productVC: ProductsVC!
    
    private var appTitleLabel = UILabel(frame: .zero)
    private var priceMenuButton = UIButton()
    
    init(service: CategoryService) {
        viewModel = HomeViewModel(service: service)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
        configureStackView()
        
        configureAppTitle()
        configureCategoriesView()
        configurePriceMenu()
        configureProductView()
        
        addBinders()
        viewModel.getCategories()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func addBinders() {
        viewModel.categories.bind { [weak self] _ in
            guard let self else { return }
            
            self.categoriesView.collectionView.reloadData()
            viewModel.selectedCategory.bind { [weak self] selectedCategory in
                guard let self else { return }
                
                guard let categoryID = selectedCategory?.categoryID else { return}
                self.productVC.viewModel.getProducts(urlString: APIUrls.products(categoryId: categoryID))
                self.showLoadingView()
            }
        }
    }
    
    private func add(childCV: UIViewController, to containerView: UIView) {
        addChild(childCV)
        containerView.addSubview(childCV.view)
        childCV.view.frame = containerView.bounds
        childCV.didMove(toParent: self)
    }
}

extension HomeScreen {
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
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 30, right: 10)
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalToSuperview()
        }
    }
    
    private func configureAppTitle() {
        stackView.addArrangedSubview(appTitleLabel)
        stackView.setCustomSpacing(50, after: appTitleLabel)
        
        appTitleLabel.text = "Food In Box"
        appTitleLabel.textColor = .label
        appTitleLabel.font = .boldSystemFont(ofSize: 40)
        appTitleLabel.textAlignment = .center
    }
    
    private func configureCategoriesView() {
        categoriesView = CategoriesView(frame: .zero)
        stackView.addArrangedSubview(categoriesView)
        
        categoriesView.collectionView.delegate = self
        categoriesView.collectionView.dataSource = self
        categoriesView.setTitle("Categories")
    }
    
    private func configurePriceMenu() {
        stackView.addArrangedSubview(priceMenuButton)
        
        priceMenuButton.setTitle(SortOption.ascending.rawValue.capitalized, for: .normal)
        priceMenuButton.setImage(UIImage(systemName: SortOption.ascending.systemName), for: .normal)
        priceMenuButton.tintColor = .secondaryLabel
        priceMenuButton.setTitleColor(.secondaryLabel, for: .normal)
        priceMenuButton.contentHorizontalAlignment = .left
        priceMenuButton.alpha = 0
        priceMenuButton.showsMenuAsPrimaryAction = true
        
        let ascendingAction = UIAction(title: "Ascending", image: UIImage(systemName: "arrow.up")) { action in
            self.productVC.viewModel.sortProducts(sortOption: .ascending)
            
            self.priceMenuButton.setTitle(SortOption.ascending.rawValue.capitalized, for: .normal)
            self.priceMenuButton.setImage(UIImage(systemName: SortOption.ascending.systemName), for: .normal)
        }
        
        let descendingAction = UIAction(title: "Descending", image: UIImage(systemName: "arrow.down")) { action  in
            self.productVC.viewModel.sortProducts(sortOption: .descending)
            
            self.priceMenuButton.setTitle(SortOption.descending.rawValue.capitalized, for: .normal)
            self.priceMenuButton.setImage(UIImage(systemName: SortOption.descending.systemName), for: .normal)
        }
        
        priceMenuButton.menu = UIMenu(title: "Price Order", children: [descendingAction, ascendingAction])
    }
    
    private func configureProductView() {
        stackView.addArrangedSubview(productView)
        stackView.setCustomSpacing(40, after: categoriesView)
        
        productView.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.deviceWidth)
        }
        
        productVC = ProductsVC(service: ProductService(), delegate: self)
        add(childCV: productVC, to: productView)
    }
}

//MARK: - CollectionView
extension HomeScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categories.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        cell.configure(viewModel.categories.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.selectedCategory.value != viewModel.categories.value[indexPath.row] {
            let cellWillBeActive = collectionView.cellForItem(at: indexPath) as! CategoryCell
            cellWillBeActive.backgroundColor = .systemOrange
            
            guard let previousCategory = viewModel.selectedCategory.value else { return }
            guard let previousCategoryIndex = viewModel.categories.value.firstIndex(of: previousCategory) else { return }
            let previousIndexPath = IndexPath(row: previousCategoryIndex, section: 0)
            
            if let cellWillBeDeactive = collectionView.cellForItem(at: previousIndexPath) as? CategoryCell {
                cellWillBeDeactive.backgroundColor = .systemGray6
            }
            
            viewModel.selectedCategory.value = viewModel.categories.value[indexPath.row]
        }
    }
}

extension HomeScreen: ProductsVCDelegate {
    func loadingStatusChanged(_ status: LoadingStatus) {
        if status == .finished {
            dismissLoadingView()
            
            self.priceMenuButton.alpha = 1
            self.priceMenuButton.setTitle(SortOption.ascending.rawValue.capitalized, for: .normal)
            self.priceMenuButton.setImage(UIImage(systemName: SortOption.ascending.systemName), for: .normal)
        }
    }
    
    func productSelected(_ product: ProductData) {
        let productDetailVC = ProductDetailVC(product: product)
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}
