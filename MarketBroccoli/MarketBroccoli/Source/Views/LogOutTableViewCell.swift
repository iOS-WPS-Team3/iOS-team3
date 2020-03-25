//
//  LogOutTableViewCell.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class LogOutTableViewCell: UITableViewCell {
  
  private let signInLabel = UILabel().then {
    $0.text = "회원 가입하고 \n다양한혜택을 받아보세요"
    $0.numberOfLines = 0
    $0.textAlignment = .center
  }
  
  private let signInBonusButton = UIButton().then {
    $0.setTitle("가입 혜택 보기 >", for: .normal)
    $0.setTitleColor(.gray, for: .normal)
  }
  
  let logInButton = UIButton().then {
    $0.setTitle("로그인/회원가입", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    $0.backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.1529411765, blue: 0.4470588235, alpha: 1)
    $0.layer.cornerRadius = 4
  }
  
  static let identifier = "LogOutTableViewCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  private func setupUI() {
    [signInLabel, signInBonusButton, logInButton].forEach {
      self.addSubview($0)
    }
    
    constraints()
  }
  private func constraints() {
    signInLabel.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(10)
      $0.centerX.equalTo(self.snp.centerX)
      $0.width.equalTo(self.snp.width).multipliedBy(0.5)
      $0.height.equalTo(self.snp.height).multipliedBy(0.25)
    }
    
    signInBonusButton.snp.makeConstraints {
      $0.top.equalTo(signInLabel.snp.bottom)
      $0.centerX.equalTo(self.snp.centerX)
      $0.height.equalTo(self.snp.height).multipliedBy(0.1)
    }
    
    logInButton.snp.makeConstraints {
      $0.top.equalTo(signInBonusButton.snp.bottom).offset(10)
      $0.centerX.equalTo(self.snp.centerX)
      $0.width.equalTo(self.snp.width).multipliedBy(0.9)
      $0.height.equalTo(self.snp.height).multipliedBy(0.2)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
    
  
}
