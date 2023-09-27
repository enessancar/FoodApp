//
//  APIUrls.swift
//  FoodApp
//
//  Created by Enes Sancar on 26.09.2023.
//

import Foundation

enum APIUrls {
    private static let baseURL = "https://api.shopiroller.com/v2.0"
    
    static let categories = "\(baseURL)/categories"
    
    static func products(categoryId: String) -> String {
        "\(baseURL)/products/advanced-filtered?categoryId=\(categoryId)"
    }
    
    static func product(productId: String) -> String {
        "\(baseURL)/products/\(productId)"
    }
}
