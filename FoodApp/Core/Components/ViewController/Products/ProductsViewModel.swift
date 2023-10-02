//
//  ProductsViewModel.swift
//  FoodApp
//
//  Created by Enes Sancar on 29.09.2023.
//

import Foundation

enum SortOption: String {
    case ascending
    case descending
    
    var systemName: String {
        switch self {
        case .ascending:
            return "arrow.up"
        case .descending:
            return "arrow.down"
        }
    }
}


class ProductsViewModel {
    
    var products: Observable<[ProductData]> = Observable([])
    var sortOption: Observable<SortOption> = Observable(.ascending)
    
    private let service: ProductService
    init(service: ProductService) {
        self.service = service
    }
    
    func getProducts(urlString: String) {
        service.downloadProducts(urlString: urlString) { [weak self] products in
            guard let self else { return }
            
            DispatchQueue.main.async {
                var tempProducts: [ProductData] = []
                for product in products {
                    if !tempProducts.contains(where: {$0.title == product.title}) {
                        tempProducts.append(product)
                    }
                }
                
                tempProducts.sort { p1, p2 in
                    if p1.campaignPrice != nil && p2.campaignPrice == nil {
                        return (p1._campaignPrice) < (p2._price)
                    } else if p1.campaignPrice == nil && p2.campaignPrice != nil {
                        return (p1._price) < (p2._campaignPrice)
                    } else if p1.campaignPrice != nil && p2.campaignPrice != nil {
                        return (p1.campaignPrice ?? 0) < (p2.campaignPrice ?? 0)
                    }
                    
                    return (p1._price) < (p2._price)
                }
                self.products.value = tempProducts
            }
        }
    }
    
    func sortProducts(sortOption: SortOption) {
        var tempProducts = products.value
        
        switch sortOption {
        case .ascending:
            
            tempProducts.sort { p1, p2 in
                if p1.campaignPrice != nil && p2.campaignPrice == nil {
                    return (p1.campaignPrice ?? 0) < (p2.price ?? 0)
                } else if p1.campaignPrice == nil && p2.campaignPrice != nil {
                    return (p1.price ?? 0) < (p2.campaignPrice ?? 0)
                } else if p1.campaignPrice != nil && p2.campaignPrice != nil {
                    return (p1.campaignPrice ?? 0) < (p2.campaignPrice ?? 0)
                }
                
                return (p1.price ?? 0) < (p2.price ?? 0)
            }
            self.products.value = tempProducts
            
        case .descending:
            
            tempProducts.sort { p1, p2 in
                if p1.campaignPrice != nil && p2.campaignPrice == nil {
                    return (p1.campaignPrice ?? 0) > (p2.price ?? 0)
                } else if p1.campaignPrice == nil && p2.campaignPrice != nil {
                    return (p1.price ?? 0) > (p2.campaignPrice ?? 0)
                } else if p1.campaignPrice != nil && p2.campaignPrice != nil {
                    return (p1.campaignPrice ?? 0) > (p2.campaignPrice ?? 0)
                }
                
                return (p1.price ?? 0) > (p2.price ?? 0)
            }
            self.products.value = tempProducts
        }
    }
}


