//
//  CategoryService.swift
//  FoodApp
//
//  Created by Enes Sancar on 27.09.2023.
//

import Foundation

final class CategoryService {
    
    private let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    public func downloadCategories(completion: @escaping([CategoryData]) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                completion(self.handleWithData(data))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func handleWithData(_ data: Data) -> [CategoryData] {
        do {
            let category = try JSONDecoder().decode(Category.self, from: data)
            guard let categoryData = category.data else {
                return []
            }
            return categoryData
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
