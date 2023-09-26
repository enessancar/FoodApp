//
//  Category.swift
//  FoodApp
//
//  Created by Enes Sancar on 26.09.2023.
//

import Foundation

struct Category: Decodable {
    let data: [CategoryData]?
}

struct CategoryData: Decodable, Equatable {
    let categoryID, name: String?
    let icon: String?
    let totalProducts: Int?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case name, icon, totalProducts
    }
}
