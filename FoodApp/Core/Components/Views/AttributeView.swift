//
//  AttributeView.swift
//  FoodApp
//
//  Created by Enes Sancar on 28.09.2023.
//

import UIKit
import SnapKit

final class AttributeView: UIView {
    
    private var headerLabel: UILabel!
    private var bodyLabel: UILabel!
    
    init(headerText: String, bodyText: String) {
        super.init(frame: .zero)
        
        configureHeaderLabel(headerText: headerText)
        configureBodyLabel(bodyText: bodyText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHeaderLabel(headerText: String) {
        headerLabel = UILabel(frame: .zero)
        addSubview(headerLabel)
        
        headerLabel.text = headerText
        headerLabel.font = .systemFont(ofSize: 16)
        headerLabel.textColor = .secondaryLabel
        
        headerLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
    }
    
    private func configureBodyLabel(bodyText: String) {
        bodyLabel = UILabel(frame: .zero)
        addSubview(bodyLabel)
        
        bodyLabel.text = bodyText
        bodyLabel.font = .boldSystemFont(ofSize: 20)
        bodyLabel.textColor = .secondaryLabel
        
        bodyLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
