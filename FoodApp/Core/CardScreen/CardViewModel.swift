//
//  CardViewModel.swift
//  FoodApp
//
//  Created by Enes Sancar on 1.10.2023.
//

import Foundation

class CardViewModel {
    
    var products: Observable<[ProductData]> = Observable([])
    
    var totalPrice: Double {
        products.value.reduce(0) { partialResult, product in
            if product.campaignPrice != nil {
                return partialResult + (product._campaignPrice)
            }
            return partialResult + (product._price)
        }
    }
    
    func getProducts() {
        ProductStore.retrieveProducts { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.products.value = products
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
