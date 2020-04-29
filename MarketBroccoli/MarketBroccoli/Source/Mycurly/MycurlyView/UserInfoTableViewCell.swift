//
//  UserInfoTableViewCell.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import Kingfisher
import SnapKit
import Then
import UIKit

protocol UserInfoTableViewCellDelgate: class {
  func leftButtonTouched(_ button: UIButton)
  
  func rightButtonTouched(_ button: UIButton)
}

final class UserInfoTableViewCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "UserInfoTableViewCell"
  weak var delegate: UserInfoTableViewCellDelgate?
  
  private lazy var userProfileImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.layer.borderWidth = 1.0
    $0.layer.borderColor = UIColor.gray.cgColor
    $0.layer.cornerRadius = 6.0
    $0.layer.masksToBounds = true
  }
  private lazy var welcomeLabel = UILabel().then {
    $0.text = "웰컴"
    $0.textColor = .lightGray
    $0.textAlignment = .center
  }
  
  private lazy var userNameLabel = UILabel().then {
    $0.textAlignment = .left
    $0.numberOfLines = 1
    $0.textColor = .label
    $0.font = .systemFont(ofSize: 18, weight: .medium)
  }
  private lazy var extraInfoLabel = UILabel().then {
    $0.textAlignment = .left
    $0.numberOfLines = 1
    $0.textColor = .label
    $0.font = .systemFont(ofSize: 16, weight: .light)
    $0.text = "5% 적립 + 최초 1회 무료배송"
  }
  private lazy var leftButton = UIButton(type: .system).then {
    $0.layer.masksToBounds = true
    $0.backgroundColor = .kurlyGray3
    $0.setTitleColor(.black, for: .normal)
    $0.titleLabel?.textAlignment = .center
    $0.setTitle("전체등급 보기", for: .normal)
    $0.addTarget(self, action: #selector(leftButtonTouched(_:)), for: .touchUpInside)
  }
  private lazy var rightButton = UIButton(type: .system).then {
    $0.layer.cornerRadius = $0.bounds.height / 2
    $0.layer.masksToBounds = true
    $0.backgroundColor = .kurlyGray3
    $0.setTitleColor(.black, for: .normal)
    $0.titleLabel?.textAlignment = .center
    $0.setTitle("다음 달 예상등급 보기", for: .normal)
    
    $0.addTarget(self, action: #selector(rightButtonTouched(_:)), for: .touchUpInside)
  }
  
  // MARK: - Initialization
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configureCell()
    addAllView()
    setupAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    makeRoundButtonCorner(leftButton)
    makeRoundButtonCorner(rightButton)
  }
  
  // MARK: - Configuration
  
  private func configureCell() {
    // 선택되어있을 때에도 배경색이 바뀌지 않기하기 위함
    self.selectedBackgroundView = UIView()
  }
  
  // MARK: - Setup UI
  
  private func addAllView() {
    contentView.addSubviews([userProfileImageView, userNameLabel, extraInfoLabel, leftButton, rightButton])
    userProfileImageView.addSubview(welcomeLabel)
  }
  
  private func setupAutoLayout() {
    userProfileImageView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(16)
      $0.size.equalTo(50)
    }
    
    welcomeLabel.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
    
    userNameLabel.snp.makeConstraints {
      $0.top.equalTo(userProfileImageView)
      $0.leading.equalTo(userProfileImageView.snp.trailing).offset(16)
      $0.bottom.equalTo(userProfileImageView.snp.centerY)
      $0.trailing.equalToSuperview().inset(16)
    }
    
    extraInfoLabel.snp.makeConstraints {
      $0.leading.trailing.equalTo(userNameLabel)
      $0.bottom.equalTo(userProfileImageView)
    }
    
    leftButton.snp.makeConstraints {
      $0.top.equalTo(userProfileImageView.snp.bottom).offset(16)
      $0.leading.equalTo(userProfileImageView)
      $0.bottom.equalToSuperview().inset(16)
      $0.width.equalToSuperview().multipliedBy(0.44)
    }
    
    rightButton.snp.makeConstraints {
      $0.top.bottom.equalTo(leftButton)
      $0.trailing.equalTo(extraInfoLabel)
      $0.width.height.equalTo(leftButton)
    }
  }
  
  private func makeRoundButtonCorner(_ button: UIButton) {
    button.layer.cornerRadius = button.bounds.height / 2
  }
  
  // MARK: - Action Handler
  
  @objc
  private func leftButtonTouched(_ button: UIButton) {
    delegate?.leftButtonTouched(button)
  }
  
  @objc
  private func rightButtonTouched(_ button: UIButton) {
    delegate?.rightButtonTouched(button)
  }
  
  func configure(userProfileImageResource: ImageResource, userName: String, extraInfo: String) {
    userProfileImageView.kf.setImage(with: userProfileImageResource)
    userNameLabel.text = "\(userName)님"
    extraInfoLabel.text = extraInfo
  }
}

extension UserInfoTableViewCell {
  func configure(name: String) {
    userNameLabel.text = "\(name)님"
  }
}
