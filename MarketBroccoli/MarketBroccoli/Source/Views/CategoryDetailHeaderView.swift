//
//  CategoryDetailHeaderView.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/17.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CategoryDetailHeaderView: UIScrollView {
  weak var customDelegate: MenuBarCategoryTouchProtocol?
  // MARK: - Properties
  func categories(categories: [String]) {
    let labels = categories.map { name -> UILabel in
      let label = UILabel().then {
        $0.textColor = .gray
        $0.text = name
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.isUserInteractionEnabled = true
      }
      return label
    }
    self.addSubviews(labels)
    
    for idx in 0..<labels.count {
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTouched(_:)))
      labels[idx].tag = 9999 - idx
      labels[idx].addGestureRecognizer(tapGesture)
      if idx == 0 {
        labels[idx].snp.makeConstraints {
          $0.top.bottom.equalToSuperview()
          $0.leading.equalToSuperview().offset(16)
        }
      } else if idx == labels.count - 1 {
        labels[idx].snp.makeConstraints {
          $0.top.bottom.equalToSuperview()
          $0.leading.equalTo(labels[idx - 1].snp.trailing).offset(10)
          $0.trailing.equalToSuperview().offset(-16)
        }
      } else {
        labels[idx].snp.makeConstraints {
          $0.top.bottom.equalToSuperview()
          $0.leading.equalTo(labels[idx - 1].snp.trailing).offset(10)
        }
      }
      labels[idx].snp.makeConstraints {
        $0.height.equalTo(self)
      }
    }
  }
  
    // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.showsHorizontalScrollIndicator = false
    setupUI()
//    setupTitle()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    self.backgroundColor = .white
  }
}
extension CategoryDetailHeaderView {
  @objc private func cellTouched(_ sender: UITapGestureRecognizer) {
    guard let delegate = customDelegate else { return }
    delegate.cellTouch(index: 9999 - (sender.view?.tag ?? 0))
  }
}
