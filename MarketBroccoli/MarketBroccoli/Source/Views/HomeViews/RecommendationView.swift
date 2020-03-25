//
//  RecommendationView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Then
import SnapKit

class RecommendationView: UIView {
  let tableView = UITableView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension RecommendationView {
  private func setupUI() {
    self.addSubview(tableView)
    
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
