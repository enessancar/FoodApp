//
//  TabBarController.swift
//  FoodApp
//
//  Created by Enes Sancar on 27.09.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    init(service: CategoryService) {
        super.init(nibName: nil, bundle: nil)
        
        configureTabBar()
        configureNavigationBar()
        
        viewControllers = [createHomeScreen(service: service), createCartScreen()]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureNavigationBar()
    }
    
    private func createHomeScreen(service: CategoryService) -> UINavigationController {
        let homeScreen = HomeScreen(service: service)
        homeScreen.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        return UINavigationController(rootViewController: homeScreen)
    }
    
    private func createCartScreen() -> UINavigationController {
        let cardScreen = CardScreen()
        cardScreen.tabBarItem = UITabBarItem(title: "Card", image: UIImage(systemName: "cart.fill"), tag: 1)
        
        return UINavigationController(rootViewController: cardScreen)
    }
    
    private func configureTabBar() {
        UITabBar.appearance().tintColor = .systemOrange
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        } else {
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
    }
    
    private func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemOrange
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
