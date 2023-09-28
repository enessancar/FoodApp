//
//  EmptyStateView.swift
//  FoodApp
//
//  Created by Enes Sancar on 28.09.2023.
//

import UIKit
import SnapKit

final class EmptyStateView: UIView {
    
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    
    //MARK: - Init
    init(title: String, message: String) {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        configureTitleLabel(title: title)
        configureMessageLabel(message: message)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureTitleLabel(title: String) {
        titleLabel = UILabel(frame: .zero)
        addSubview(titleLabel)
        titleLabel.text = title
        
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureMessageLabel(message: String) {
        messageLabel = UILabel(frame: .zero)
        addSubview(messageLabel)
        
        messageLabel.text = message
        messageLabel.font = .systemFont(ofSize: 24)
        messageLabel.textColor = .secondaryLabel
        messageLabel.textAlignment = .center
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
