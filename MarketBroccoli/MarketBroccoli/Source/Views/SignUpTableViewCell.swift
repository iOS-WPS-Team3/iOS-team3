//
//  SignUpTableViewCell.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class SignupTableViewCell: UITableViewCell {
  
  private let idLabel = UILabel().then {
    $0.text = "아이디"
  }
  private var idTextFeild = UITextField()
  private let checkIDButton = UIButton().then {
    $0.setTitle("중복확인", for: .normal)
    $0.backgroundColor = .purple
    $0.setTitleColor(.white, for: .normal)
  }
//  private let idExplanationLabel = UILabel()
//  private let checkingIdLabel = UILabel()
  
  private let secretNumberLabel = UILabel().then {
    $0.text = "비밀번호"
  }
  private var secretTextFeild = UITextField()
  private let checkSecretNumberLabel = UILabel().then {
    $0.text = "비밀번호 확인"
  }
  
  private var checkSecretNumberTextFeild = UITextField()
  private let nameLabel = UILabel().then {
    $0.text = "이름"
  }
  private var nameTextFeild = UITextField()
  private let emailLabel = UILabel().then {
    $0.text = "이메일"
  }
  private var emailTextFeild = UITextField()
  private let cellphoneLabel = UILabel().then {
    $0.text = "휴대폰"
  }
  
  private var cellphoneTextField = UITextField()
  private let receivingCellphoneNumberButton = UIButton().then {
    $0.setTitle("인증번호 받기", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .gray
  }
  private var checkingReceivingNumberTexField = UITextField()

  private let checkingReceivingButton = UIButton().then {
    $0.setTitle("인증번호 확인", for: .normal)
    $0.setTitleColor(.gray, for: .normal)
    $0.backgroundColor = .white
  }
  private let addressLabel = UILabel().then {
    $0.text = "배송주소"
  }
  private let addressCheckingLabel = UILabel().then {
    $0.text = "배송 가능 여부를 확인할 수 있습니다."
  }
  private let searchingAddressButton = UIButton().then {
    $0.setTitle("주소 검색", for: .normal)
    $0.backgroundColor = .purple
    $0.setTitleColor(.white, for: .normal)
  }
  private let birthdayLabel = UILabel().then {
    $0.text = "생년월일"
  }
  
  private var birthdayYearTextField = UITextField().then {
    $0.placeholder = "YYYY"
    $0.borderStyle = .none
  }
  private let firstSlashLabel = UILabel().then {
    $0.text = "/"
  }
  private var birthdayMonthTextField = UITextField().then {
    $0.placeholder = "MM"
    $0.borderStyle = .none
  }
  private let secondSlashLabel = UILabel().then {
    $0.text = "/"
  }
  private var birthdayDayTextField = UITextField().then {
    $0.placeholder = "DD"
    $0.borderStyle = .none
  }
  
  private let genderLabel = UILabel().then {
    $0.text = "성별"
  }
  private let maleLabel = UILabel().then {
    $0.text = "남자"
  }
  private let femaleLabel = UILabel().then {
    $0.text = "여자"
  }
  private let noChoice = UILabel().then {
    $0.text = "선택안함"
  }

  private let additionalConditionLabel = UILabel().then {
    $0.text = "추가입력 사항"
  }
 
  private let additionalExplanationLabel = UILabel().then {
    $0.text = "추천인 아이디와 참여 이벤트명 중 하나마나 선택 가능합니다."
    $0.font = .systemFont(ofSize: 12)
    $0.textColor = .gray
  }
  private let recoIDLabel = UILabel().then {
    $0.text = "추천인 아이디"
  }
  private let eventName = UILabel().then {
    $0.text = "참여 이벤트명"
  }

  static let identifier = "SignupTableViewCell"
  
//  private let signUpInfos = ["아이디", "비밀번호", "비밀번호 확인", "이름", "이메일", "휴대폰"]
//  private var infoLabels = [UILabel]()
//  private var infoTextfields = [UITextField]()
//  private var infoInputForm = [UIStackView]()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
//    signUpInfos.forEach {
//      let label = UILabel()
//      label.text = $0
//      infoLabels.append(label)
//
//      let textField = textFieldStyle(placeholder: "abc")
//      infoTextfields.append(textField)
//
//      let stackView = UIStackView()
//      stackView.axis = .vertical
//      stackView.alignment = .leading
//      stackView.distribution = .fillProportionally
//      stackView.spacing = 4
//      stackView.addArrangedSubview(label)
//      stackView.addArrangedSubview(textField)
//      infoInputForm.append(stackView)
//    }
    setupUI()
    constraints()
  }
  
  private func setupUI() {
    idTextFeild = self.textFieldStyle(placeholder: "예: marketkurly12")
    secretTextFeild = self.textFieldStyle(placeholder: "비밀번호를 입력해주세요")
    checkSecretNumberTextFeild = self.textFieldStyle(placeholder: "비밀번호를 한번 더 입력해 주세요")
    nameTextFeild = self.textFieldStyle(placeholder: "고객님의 이름을 입력해주세요")
    emailTextFeild = self.textFieldStyle(placeholder: "예: marketkurly@kurly.com")
    cellphoneTextField = self.textFieldStyle(placeholder: "'-' 없이 숫자만")
    checkingReceivingNumberTexField = self.textFieldStyle(placeholder: "")
  }
  
  private func constraints() {
    [idLabel, idTextFeild, checkIDButton, secretNumberLabel, secretTextFeild, checkSecretNumberLabel, checkSecretNumberTextFeild, nameLabel, nameTextFeild, emailLabel, emailTextFeild, cellphoneLabel, cellphoneTextField, receivingCellphoneNumberButton, checkingReceivingNumberTexField, checkingReceivingButton, addressLabel, addressCheckingLabel, searchingAddressButton, birthdayLabel, birthdayYearTextField, firstSlashLabel, birthdayMonthTextField, secondSlashLabel, birthdayDayTextField, genderLabel, maleLabel, femaleLabel, noChoice, additionalConditionLabel, additionalExplanationLabel, recoIDLabel, eventName].forEach {
      self.addSubview($0)
    }

    idLabel.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(10)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).dividedBy(9)
    }
    
    idTextFeild.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(30)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.7)
    }
    
    checkIDButton.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(30)
      $0.leading.equalTo(idTextFeild.snp.trailing).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.2)
    }
    
    secretNumberLabel.snp.makeConstraints {
      $0.top.equalTo(idTextFeild.snp.bottom).offset(10)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.2)
    }
    
    secretTextFeild.snp.makeConstraints {
      $0.top.equalTo(secretNumberLabel.snp.bottom)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.92)
    }
    
    checkSecretNumberLabel.snp.makeConstraints {
      $0.top.equalTo(secretTextFeild.snp.bottom).offset(10)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.4)
    }
    
    checkSecretNumberTextFeild.snp.makeConstraints {
      $0.top.equalTo(checkSecretNumberLabel.snp.bottom)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.92)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(checkSecretNumberTextFeild.snp.bottom).offset(10)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.2)
    }
    
    nameTextFeild.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.92)
    }
    
    emailLabel.snp.makeConstraints {
      $0.top.equalTo(nameTextFeild.snp.bottom).offset(10)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.92)
    }
    
    emailTextFeild.snp.makeConstraints {
      $0.top.equalTo(emailLabel.snp.bottom)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.92)
    }
    
    cellphoneLabel.snp.makeConstraints {
      $0.top.equalTo(emailTextFeild.snp.bottom).offset(10)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.2)
    }
    
    cellphoneTextField.snp.makeConstraints {
      $0.top.equalTo(emailTextFeild.snp.bottom).offset(30)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.5)
    }
    
    receivingCellphoneNumberButton.snp.makeConstraints {
      $0.top.equalTo(emailTextFeild.snp.bottom).offset(30)
      $0.leading.equalTo(cellphoneTextField.snp.trailing).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.4)
    }
    
    checkingReceivingNumberTexField.snp.makeConstraints {
      $0.top.equalTo(cellphoneTextField.snp.bottom).offset(10)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.5)
    }
    
    checkingReceivingButton.snp.makeConstraints {
      $0.top.equalTo(receivingCellphoneNumberButton.snp.bottom).offset(10)
      $0.leading.equalTo(checkingReceivingNumberTexField.snp.trailing).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.4)
    }
    
    addressLabel.snp.makeConstraints {
      $0.top.equalTo(checkingReceivingNumberTexField.snp.bottom).offset(20)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.2)
    }
    
    addressCheckingLabel.snp.makeConstraints {
      $0.top.equalTo(addressLabel.snp.bottom)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.6)
    }
    
    searchingAddressButton.snp.makeConstraints {
      $0.top.equalTo(addressCheckingLabel.snp.bottom).offset(20)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.92)
    }
    
    birthdayLabel.snp.makeConstraints {
      $0.top.equalTo(searchingAddressButton.snp.bottom).offset(20)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.2)
    }
    
    birthdayYearTextField.snp.makeConstraints {
      $0.top.equalTo(searchingAddressButton.snp.bottom).offset(50)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).dividedBy(4)
    }
    
    firstSlashLabel.snp.makeConstraints {
      $0.top.equalTo(searchingAddressButton.snp.bottom).offset(50)
      $0.leading.equalTo(birthdayYearTextField.snp.trailing)
    }
    
    birthdayMonthTextField.snp.makeConstraints {
      $0.top.equalTo(searchingAddressButton.snp.bottom).offset(50)
      $0.leading.equalTo(firstSlashLabel.snp.trailing)
      $0.width.equalTo(self.snp.width).dividedBy(4)
    }
    
    secondSlashLabel.snp.makeConstraints {
      $0.top.equalTo(searchingAddressButton.snp.bottom).offset(50)
      $0.leading.equalTo(birthdayMonthTextField.snp.trailing)
    }
    
    birthdayDayTextField.snp.makeConstraints {
      $0.top.equalTo(searchingAddressButton.snp.bottom).offset(50)
      $0.leading.equalTo(secondSlashLabel.snp.trailing)
      $0.width.equalTo(self.snp.width).dividedBy(4)
    }
    
    genderLabel.snp.makeConstraints {
      $0.top.equalTo(birthdayYearTextField.snp.bottom).offset(30)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.2)
    }
    
    maleLabel.snp.makeConstraints {
      $0.top.equalTo(genderLabel.snp.bottom).offset(30)
      $0.leading.equalTo(self.snp.leading).offset(50)
      $0.width.equalTo(self.snp.width).multipliedBy(0.2)
    }
    
    femaleLabel.snp.makeConstraints {
      $0.top.equalTo(maleLabel.snp.bottom).offset(10)
      $0.leading.equalTo(self.snp.leading).offset(50)
      $0.width.equalTo(self.snp.width).multipliedBy(0.2)
    }
    
    noChoice.snp.makeConstraints {
      $0.top.equalTo(femaleLabel.snp.bottom).offset(10)
      $0.leading.equalTo(self.snp.leading).offset(50)
      $0.width.equalTo(self.snp.width).multipliedBy(0.2)
    }
    
    additionalConditionLabel.snp.makeConstraints {
      $0.top.equalTo(noChoice.snp.bottom).offset(30)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.4)
    }
    additionalExplanationLabel.snp.makeConstraints {
      $0.top.equalTo(additionalConditionLabel.snp.bottom).offset(10)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.8)
    }
    
    recoIDLabel.snp.makeConstraints {
      $0.top.equalTo(additionalExplanationLabel.snp.bottom).offset(30)
      $0.leading.equalTo(self.snp.leading).offset(50)
      $0.width.equalTo(self.snp.width).multipliedBy(0.4)
    }
    
    eventName.snp.makeConstraints {
      $0.top.equalTo(recoIDLabel.snp.bottom).offset(30)
      $0.leading.equalTo(self.snp.leading).offset(50)
      $0.width.equalTo(self.snp.width).multipliedBy(0.4)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SignupTableViewCell {
  func textFieldStyle(placeholder: String) -> UITextField {
      let textField = UITextField()
      textField.placeholder = placeholder
      textField.borderStyle = .roundedRect
      textField.clearButtonMode = .whileEditing
      return textField
  }
}
