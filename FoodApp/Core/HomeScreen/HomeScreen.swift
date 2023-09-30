//
//  HomeScreen.swift
//  FoodApp
//
//  Created by Enes Sancar on 29.09.2023.
//

import UIKit
import SnapKit

final class HomeScreen: DataLoadingVC {
    
    private let viewModel: HomeViewModel! = nil
    
    private let scrollView = UIScrollView(frame: .zero)
    private let stackView  = UIStackView()
    private var categoriesView: CategoriesView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
