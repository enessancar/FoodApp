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
