//
//  CategoryTableViewCell.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import SnapKit

class CategoryTableViewCell: UITableViewCell {
  static let identifier = "categoryCell"
  
  private let iconImage = UIImageView().then {
    $0.image = UIImage(named: "icon_sauce")
    $0.contentMode = .scaleAspectFit
  }
  private let title = UILabel() 
  private let arrowImage = UIImageView().then {
    $0.image = UIImage(systemName: "chevron.down")
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .darkGray
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
    setupLayout()
  }
  
  func selectState(data: CategoryModel) {
    switch data.select {
    case true:
      arrowImage.image = UIImage(systemName: "chevron.up")
      iconImageName(name: data.imagePurple)
      title.textColor = #colorLiteral(red: 0.3176470588, green: 0.1529411765, blue: 0.4470588235, alpha: 1)
    default:
      arrowImage.image = UIImage(systemName: "chevron.down")
      iconImageName(name: data.imageBlack)
      title.textColor = .black
    }
  }
  
  private func setupUI() {
    [iconImage, title, arrowImage].forEach {
      contentView.addSubview($0)
    }
  }
  
  private func setupLayout() {
    iconImage.snp.makeConstraints { (make) -> Void in
      make.centerY.equalTo(contentView.snp.centerY)
      make.leading.equalTo(contentView.snp.leading).offset(16)
      make.width.height.equalTo(32)
    }
    title.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(contentView.snp.top).offset(16)
      make.leading.equalTo(iconImage.snp.trailing).offset(10)
      make.bottom.equalToSuperview().offset(-16)
    }
    arrowImage.snp.makeConstraints { (make) -> Void in
      make.centerY.equalTo(contentView.snp.centerY)
      make.trailing.equalTo(contentView.snp.trailing).offset(-20)
      make.width.height.equalTo(20)
    }
  }
  
  func titleName(name: String) {
    title.text = name
  }
  
  func iconImageName(name: String) {
    iconImage.image = UIImage(named: name)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
