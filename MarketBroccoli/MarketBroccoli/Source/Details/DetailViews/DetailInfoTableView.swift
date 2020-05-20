//
//  DetailInfoTableView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/03.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class DetailCautionView: UIView {
  let cautionLabel = UILabel().then {
    $0.text = "준비중입니다."
    $0.textColor = .kurlyPurple1
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension DetailCautionView {
  private func setupUI() {
    self.addSubviews([cautionLabel])
    cautionLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}
