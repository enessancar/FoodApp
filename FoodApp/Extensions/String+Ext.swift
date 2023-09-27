//
//  String+Ext.swift
//  FoodApp
//
//  Created by Enes Sancar on 26.09.2023.
//

import UIKit

extension String {
    func asTRYCurrency() -> Self {
        var string = self
        string.append(" ₺")
        return string
    }
}

extension CGFloat {
    static let deviceWidth = UIScreen.main.bounds.width
    static let deviceHeight = UIScreen.main.bounds.height
}
