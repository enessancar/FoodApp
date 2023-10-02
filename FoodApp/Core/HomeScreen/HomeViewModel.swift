//
//  HomeViewModel.swift
//  FoodApp
//
//  Created by Enes Sancar on 29.09.2023.
//

import Foundation

class HomeViewModel {
    
    var categories: Observable<[CategoryData]> = Observable([])
    var selectedCategory: Observable<CategoryData?> = Observable(nil)
    
    private let service: CategoryService
    init(service: CategoryService) {
        self.service = service
    }
    
    func getCategories() {
        service.downloadCategories { [weak self] returnedCategories in
            guard let self else { return }
            DispatchQueue.main.async {
                self.categories.value = returnedCategories
                self.selectedCategory.value = returnedCategories.first
            }
        }
    }
}
