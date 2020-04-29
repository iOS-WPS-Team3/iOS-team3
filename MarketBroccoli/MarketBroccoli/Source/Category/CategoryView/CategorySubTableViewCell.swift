//
//  CategorySubTableViewCell.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/02.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Alamofire

class CategorySubTableViewCell: UITableViewCell {
  static let identifier: String = "categorySubCell"
  
  private let title = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 14)
//    $0.textColor = .darkGray
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUI()
    setLayout()
  }
  private func setUI() {
    contentView.addSubview(title)
  }
  
  private func setLayout() {
    title.snp.makeConstraints { (make) -> Void in
      make.top.equalToSuperview().offset(12)
      make.leading.equalToSuperview().offset(60)
      make.centerY.equalToSuperview()
      make.bottom.equalToSuperview().offset(-12)
    }
  }
  
  func titleName(name: String) {
    title.text = name
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
