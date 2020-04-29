//
//  CategorySectionHeaderView.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/07.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CategorySectionHeaderView: UIView {
  private let title = UILabel().then {
    $0.text = "컬리의 추천"
    $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    $0.textColor = .black
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    self.backgroundColor = .white
    self.addSubview(title)
  }
  private func setupLayout() {
    title.snp.makeConstraints { (make) -> Void in
      make.leading.equalToSuperview().offset(16)
      make.top.equalToSuperview().offset(16)
      make.trailing.bottom.equalToSuperview()
    }
  }
}
