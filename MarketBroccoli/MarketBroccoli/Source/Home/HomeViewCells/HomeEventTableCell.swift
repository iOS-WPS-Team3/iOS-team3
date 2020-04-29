//
//  HomeEventTableCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class HomeEventTableCell: UITableViewCell {
  private let cellTitleLabel = UILabel().then {
    $0.text = "이벤트"
    $0.font = .boldSystemFont(ofSize: 20)
  }
  private let eventStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 8
    $0.distribution = .fillEqually
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI
extension HomeEventTableCell {
  private func makeStackView() {
    for index in 1...3 {
      let innerView = UIView()
      let imageView = UIImageView().then {
        $0.image = UIImage(named: "cloud\(index)")
        $0.contentMode = .scaleToFill
      }
      let titleLabel = UILabel().then {
        $0.text = "구름이 사진전"
      }
      let subTitleLabel = UILabel().then {
        $0.text = "구름이 보고 가세요"
      }
      innerView.addSubviews([imageView, titleLabel, subTitleLabel])
      
      imageView.snp.makeConstraints {
        $0.top.leading.bottom.equalToSuperview()
        $0.width.height.equalTo(80)
      }
      
      titleLabel.snp.makeConstraints {
        $0.leading.equalTo(imageView.snp.trailing).offset(20)
        $0.trailing.equalToSuperview()
        $0.bottom.equalTo(imageView.snp.centerY)
      }
      
      subTitleLabel.snp.makeConstraints {
        $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        $0.leading.trailing.equalTo(titleLabel)
      }
      
      eventStackView.addArrangedSubview(innerView)
    }
  }
  private func setupAttr() {
    self.backgroundColor = .kurlyGray3
  }
  
  private func setupUI() {
    makeStackView()
    setupAttr()
    self.contentView.addSubviews([cellTitleLabel, eventStackView])
    cellTitleLabel.snp.makeConstraints {
      $0.top.equalTo(self.contentView).offset(40)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    }
    
    eventStackView.snp.makeConstraints {
      $0.top.equalTo(cellTitleLabel.snp.bottom).offset(8)
      $0.leading.bottom.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 40, right: 0))
    }
  }
}
