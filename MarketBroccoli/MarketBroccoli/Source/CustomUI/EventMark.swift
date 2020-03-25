//
//  EventMark.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Then
import SnapKit

class EventMark: UIView {
    let textLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    convenience init(text: String) {
        self.init()
        textLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EventMark {
    private func setupUI() {
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
        }
    }
}
