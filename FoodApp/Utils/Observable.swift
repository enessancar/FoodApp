//
//  Observable.swift
//  FoodApp
//
//  Created by Enes Sancar on 29.09.2023.
//

import Foundation

class Observable<T> {
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> ())?
    
    init(_ value :T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> ()) {
        self.listener = listener
    }
}
