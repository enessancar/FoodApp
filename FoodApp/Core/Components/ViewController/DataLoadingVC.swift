//
//  DataLoadingVC.swift
//  FoodApp
//
//  Created by Enes Sancar on 27.09.2023.
//

import UIKit
import SnapKit

class DataLoadingVC: UIViewController {
    
    private var containerView: UIView!
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            guard self.containerView != nil else { return }
            
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}

