//
//  CardScreen.swift
//  FoodApp
//
//  Created by Enes Sancar on 1.10.2023.
//

import UIKit
import SnapKit

final class CardScreen: UIViewController {
    
    private var emptyStateView: EmptyStateView!
    private var tableView = UITableView(frame: .zero)
    private var cardConfirmView: CardConfirmView!
    
    private var viewModel = CardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Food in Card"
        navigationItem.backButtonTitle = "Back"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        configureEmptyStateView()
        configureCardConfirmView()
        configureTableView()
        addBinders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getProducts()
    }
    
    private func addBinders() {
        viewModel.products.bind { [weak self] products in
            guard let self else { return }
            if products.isEmpty {
                self.view.bringSubviewToFront(emptyStateView)
            } else {
                self.tableView.reloadData()
                self.cardConfirmView.setPrice(totalPrice: self.viewModel.totalPrice)
                
                view.bringSubviewToFront(tableView)
                view.bringSubviewToFront(cardConfirmView)
            }
        }
    }
    
    private func configureEmptyStateView() {
        emptyStateView = EmptyStateView(title: "Your card is empty! 🥲", message: "Let's add some delicious dishes!")
        view.addSubview(emptyStateView)
        
        emptyStateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CardScreen {
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(cardConfirmView.snp.top)
        }
    }
    
    private func configureCardConfirmView() {
        cardConfirmView = CardConfirmView(delegate: self)
        view.addSubview(cardConfirmView)
        
        cardConfirmView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(10)
        }
    }
}

extension CardScreen: CardConfirmCiewProtocol {
    func confirmButtonPressed() {
        viewModel.products.value.removeAll()
        ProductStore.removeAll()
    }
}

//MARK: - TableView
extension CardScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell else {
            return UITableViewCell()
        }
        cell.configure(viewModel.products.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductDetailVC(product: viewModel.products.value[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
