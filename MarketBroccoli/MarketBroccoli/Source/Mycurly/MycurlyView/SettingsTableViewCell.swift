//
//  LogOutTableViewCell.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.

import UIKit

protocol SettingsTableViewCellDelegate: class {
  func signInBonusButtonTouched(_ button: UIButton)
  func logInButtonDidTouched(_ button: UIButton)
}

class SettingsTableViewCell: UITableViewCell {
  private let signInLabel = UILabel().then {
    $0.text = "회원 가입하고 \n다양한혜택을 받아보세요"
    $0.numberOfLines = 0
    $0.textAlignment = .center
  }
  private lazy var signInBonusButton = UIButton().then {
    $0.setTitle("가입 혜택 보기 >", for: .normal)
    $0.setTitleColor(.gray, for: .normal)
    
    $0.addTarget(self, action: #selector(whenSignInBounsButtonDidTouchUpInside(_:)), for: .touchUpInside)
  }
  private lazy var logInButton = UIButton().then {
    $0.setTitle("로그인/회원가입", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    $0.backgroundColor = .kurlyMainPurple
    $0.layer.cornerRadius = 4
    
    $0.addTarget(self, action: #selector(whenLogInButtonDidTouchUpInside(_:)), for: .touchUpInside)
  }
  
  weak var delegate: SettingsTableViewCellDelegate?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ACTIONS
extension SettingsTableViewCell {
  @objc private func whenSignInBounsButtonDidTouchUpInside(_ button: UIButton) {
    delegate?.signInBonusButtonTouched(button)
  }
  
  @objc private func whenLogInButtonDidTouchUpInside(_ button: UIButton) {
    delegate?.logInButtonDidTouched(button)
  }
}

// MARK: - UI
extension SettingsTableViewCell {
  private func setupUI() {
    contentView.addSubviews([signInLabel, signInBonusButton, logInButton])
    constraints()
  }
  
  private func constraints() {
    signInLabel.snp.makeConstraints {
      $0.top.equalTo(contentView.snp.top).offset(20)
      $0.centerX.equalTo(contentView.snp.centerX)
      $0.width.equalTo(contentView.snp.width).multipliedBy(0.5)
    }
    
    signInBonusButton.snp.makeConstraints {
      $0.top.equalTo(signInLabel.snp.bottom)
      $0.centerX.equalTo(signInLabel)
    }
    
    logInButton.snp.makeConstraints {
      $0.top.equalTo(signInBonusButton.snp.bottom).offset(10)
      $0.centerX.equalTo(contentView.snp.centerX)
      $0.bottom.equalTo(contentView.snp.bottom).offset(-20)
      $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
      $0.height.equalTo(50)
    }
  }
}
