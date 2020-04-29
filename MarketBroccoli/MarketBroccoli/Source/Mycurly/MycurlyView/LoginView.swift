//
//  LoginView.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/16.
//  Copyright © 2020 Team3. All rights reserved.
import UIKit
import SnapKit

protocol LoginViewDelegate: class {
  func loginButtonTouched()
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  func idAndSecretFindButtonTouched(_ sender: UIButton)
  func signupButtonTouched(_ sender: UIButton)
}

class LoginView: UIView {
  // MARK: - 프로퍼티
  weak var delegate: LoginViewDelegate?
  lazy var idTextField = UITextField().then {
    $0.placeholder = "아이디를 입력해주세요"
    $0.textFieldStyle()
    $0.autocapitalizationType = .none
    $0.addTarget(self, action: #selector(textFieldShouldReturn), for: .primaryActionTriggered)
  }
  
  lazy var pwTextField = UITextField().then {
    $0.placeholder = "비밀번호를 입력해주세요"
    $0.isSecureTextEntry = true
    $0.textFieldStyle()
    $0.addTarget(self, action: #selector(textFieldShouldReturn), for: .primaryActionTriggered)
  }
  
  var logInButton = UIButton().then {
    $0.setTitle("로그인", for: .normal)
    $0.roundPurpleBtnStyle()
    $0.addTarget(self, action: #selector(loginButtonTouched), for: .touchUpInside)
  }
  
  var idFindButton = UIButton().then {
    $0.setTitle("아이디 찾기 |", for: .normal)
    $0.setTitleColor(.darkGray, for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    $0.addTarget(self, action: #selector(idAndSecretFindButtonTouched), for: .touchUpInside)
  }
  
  var pwFindButton = UIButton().then {
    $0.setTitle("비밀번호 찾기", for: .normal)
    $0.setTitleColor(.darkGray, for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    $0.addTarget(self, action: #selector(idAndSecretFindButtonTouched), for: .touchUpInside)
  }
  var signUpButton = UIButton().then {
    $0.setTitle("회원가입", for: .normal)
    $0.roundLineBtnStyle()
    $0.addTarget(self, action: #selector(signupButtonTouched), for: .touchUpInside)
  }
  
  private enum UI {
    static let margin: CGFloat = 32
    static let height: CGFloat = 14
    static let buttonBetweenMargin: CGFloat = 40
    static let buttonTopMargin: CGFloat = 12
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    setupAttribute()
  }
  private func setupAttribute() {
    self.backgroundColor = .white
  }
  // MARK: - Constraints
  private func setupUI() {
    self.addSubviews(
      [idTextField, pwTextField, logInButton, idFindButton, pwFindButton, signUpButton ])
    
    idTextField.snp.makeConstraints {
      $0.top.equalToSuperview().offset(UI.margin)
      $0.centerX.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(0.88)
      $0.height.equalToSuperview().dividedBy(UI.height)
    }
    
    pwTextField.snp.makeConstraints {
      $0.top.equalTo(idTextField.snp.bottom).offset(UI.buttonTopMargin)
      $0.centerX.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(0.88)
      $0.height.equalToSuperview().dividedBy(UI.height)
    }
    
    logInButton.snp.makeConstraints {
      $0.top.equalTo(pwTextField.snp.bottom).offset(24)
      $0.centerX.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(0.88)
      $0.height.equalToSuperview().dividedBy(UI.height)
    }
    
    idFindButton.snp.makeConstraints {
      $0.top.equalTo(logInButton.snp.bottom).offset(UI.buttonTopMargin)
      $0.centerX.equalToSuperview().offset(-UI.buttonBetweenMargin)
    }
    
    pwFindButton.snp.makeConstraints {
      $0.top.equalTo(logInButton.snp.bottom).offset(UI.buttonTopMargin)
      $0.leading.equalTo(idFindButton.snp.trailing).offset(4)
    }
    
    signUpButton.snp.makeConstraints {
      $0.top.equalTo(idFindButton.snp.bottom).offset(UI.buttonBetweenMargin)
      $0.centerX.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(0.88)
      $0.height.equalToSuperview().dividedBy(UI.height)
    }
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LoginView {
  @objc func loginButtonTouched() {
    delegate?.loginButtonTouched()
  }
  
  @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let delegate = delegate else { fatalError() }
    return delegate.textFieldShouldReturn(textField)
  }
  
  @objc func idAndSecretFindButtonTouched(_ sender: UIButton) {
    delegate?.idAndSecretFindButtonTouched(sender)
  }
  
  @objc func signupButtonTouched(_ sender: UIButton) {
    delegate?.signupButtonTouched(sender)
  }
}
