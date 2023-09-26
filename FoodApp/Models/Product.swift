//
//  Product.swift
//  FoodApp
//
//  Created by Enes Sancar on 26.09.2023.
//

import Foundation

struct Product: Codable {
    let data: [ProductData]?
}

struct ProductData: Codable, Equatable {
    let id: String?
    let title: String?
    let images: [Icon]?
    let description: String?
    let price: Double?
    let campaignPrice, shippingPrice: Double?
    let createDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title, images
        case description
        case price, campaignPrice, shippingPrice, createDate
    }
    
    var loremDescription: String {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    }
}

struct Icon: Codable, Equatable {
    let use, dontUse: String?
    
    enum CodingKeys: String, CodingKey {
        case use = "n"
        case dontUse = "t"
    }
}
