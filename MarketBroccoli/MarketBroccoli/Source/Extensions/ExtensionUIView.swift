//
//  ExtensionUIView.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UIView {
    
    func shadow() {
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
}

extension UITextField {
    
    func textFeildStyle(placeholder: String) {
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.clearButtonMode = .whileEditing
    }
}

extension UIButton {
    
    func roundPurpleBtnStyle(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.1529411765, blue: 0.4470588235, alpha: 1)
        self.layer.cornerRadius = 4
    }
    
    func roundLineBtnStyle(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.1529411765, blue: 0.4470588235, alpha: 1), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.3176470588, green: 0.1529411765, blue: 0.4470588235, alpha: 1)
        self.layer.cornerRadius = 4
    }
}
