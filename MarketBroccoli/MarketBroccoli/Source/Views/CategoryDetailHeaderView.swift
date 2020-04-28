//
//  CategoryDetailHeaderView.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/17.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CategoryDetailHeaderView: UIScrollView {
  // MARK: - Properties
  weak var customDelegate: MDCategoryTouchProtocol?
  
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
  
  private let title = UIButton().then {
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    $0.setTitleColor(UIColor.gray, for: .normal)
    //    $0.addTarget(self(), action: #selector(<#T##@objc method#>), for: .touchUpInside)
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
//    self.contentSize = CGSize()
//    self.isScrollEnabled = true
//    self.setContentOffset(<#T##contentOffset: CGPoint##CGPoint#>, animated: <#T##Bool#>) -> 여기 확인 한거
  }
  private func setupTitle() {
    [title].forEach {
      self.addSubview($0)
    }
    title.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.bottom.equalToSuperview().offset(-10)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }
  }
  func title(name: String) {
    print(#function)
    print("Content Size before set title :", self.contentSize)
    title.setTitle(name, for: .normal)
    print("Content Size after set title :", self.contentSize)
  }
}
extension CategoryDetailHeaderView {
  @objc private func cellTouched(_ sender: UITapGestureRecognizer) {
    guard let delegate = customDelegate else { return }
    delegate.cellTouch(index: 9999 - (sender.view?.tag ?? 0))
  }
}
