//  testUIView.swift
//  20200112ScrollViewPractice
//  Created by macbook on 2020/03/23.
//  Copyright © 2020 Lance. All rights reserved.
import UIKit
import WebKit

class SignupView: UIView {
  // MARK: - 프로퍼티
  weak var delegate: SignupViewDelegate?
  private lazy var idLabel = SignupLabel().then {
    $0.text = "아이디"
    $0.required = true
  }
  
  lazy var idTextField = UITextField().then {
    $0.placeholder = "예: marketkurly12"
    $0.autocapitalizationType = .none
    $0.delegate = self
    $0.addTarget(self, action: #selector(idTextFieldEditingChanged), for: .editingChanged)
    $0.signupStyle(round: .roundedRect, clearButton: .whileEditing)
  }
  
  let checkIDButton = SignupButton(
    setTitleColor: .white,
    backgroundColor: .kurlyMainPurple,
    borderWidth: nil,
    borderColor: nil
  ).then {
    $0.layer.cornerRadius = 5
    $0.setTitle("중복확인", for: .normal)
    $0.addTarget(self, action: #selector(checkIDButtonTouched), for: .touchUpInside)
  }
  
  let idLimitExplanationLabel = SignupLabel(textColor: .lightGray, font: .systemFont(ofSize: 10)).then {
    $0.text = "6자 이상의 영문 혹은 영문과 숫자를 조합"
  }
  
  let checkingIdLabel = SignupLabel(textColor: .lightGray, font: .systemFont(ofSize: 10)).then {
    $0.text = "아이디 중복확인"
  }
  
  private lazy var secretNumberLabel = SignupLabel().then {
    $0.text = "비밀번호"
    $0.required = true
  }
  
  lazy var passwordTextField = UITextField().then {
    $0.signupStyle(round: .roundedRect, clearButton: .whileEditing)
    $0.placeholder = "비밀번호를 입력해주세요"
//    $0.keyboardType = .asciiCapable
    $0.autocapitalizationType = .none
    $0.delegate = self
    $0.addTarget(self, action: #selector(passwordTextFieldEditingChanged(_:text:)), for: .editingChanged)
  }
  
  let tenSyllableLabel = SignupLabel(textColor: .lightGray, font: .systemFont(ofSize: 10)).then {
    $0.text = "10자 이상 입력"
  }
  
  let combinationLabel = SignupLabel(textColor: .lightGray, font: .systemFont(ofSize: 10)).then {
    $0.text = "영문/숫자/공백제외만 허용하며, 2개 이상 조합"
  }
  
  let notSameTheeNumberLabel = SignupLabel(textColor: .lightGray, font: .systemFont(ofSize: 10)).then {
    $0.text = "동일한 숫자 3개 이상 연속 사용 불가"
  }
  
  private lazy var checkSecretNumberLabel = SignupLabel().then {
    $0.text = "비밀번호 확인"
    $0.required = true
  }
  
  lazy var checkPasswordTextField = UITextField().then {
    $0.placeholder = "비밀번호를 한번 더 입력해주세요"
    $0.delegate = self
    $0.autocapitalizationType = .none
    $0.addTarget(self, action: #selector(checkPasswordTextFieldEditingChanged), for: .editingChanged)
    $0.signupStyle(round: .roundedRect, clearButton: .whileEditing)
  }
  
  let sameSecretNumberLabel = SignupLabel(textColor: .orange, font: .systemFont(ofSize: 10)).then {
    $0.text = "동일한 비밀번호를 입력해주세요"
  }
  
  private lazy var nameLabel = SignupLabel().then {
    $0.text = "이름"
    $0.required = true
  }
  
  lazy var nameTextField = UITextField().then {
    $0.placeholder = "고객님의 이름을 입력해주세요"
    $0.autocapitalizationType = .none
    $0.delegate = self
    $0.signupStyle(round: .roundedRect, clearButton: .whileEditing)
    $0.addTarget(self, action: #selector(checkName), for: .editingChanged)
  }
  
  private lazy var emailLabel = SignupLabel().then {
    $0.text = "이메일"
    $0.required = true
  }
  
  lazy var emailTextFeild = UITextField().then {
    $0.placeholder = "예: marketkurly@kurly.com"
    $0.keyboardType = .emailAddress
    $0.autocapitalizationType = .none
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.clear.cgColor
    $0.delegate = self
    $0.addTarget(self, action: #selector(emailTextFeildEditingChanged), for: .editingChanged)
    $0.signupStyle(round: .roundedRect, clearButton: .whileEditing)
  }
  
  private lazy var cellphoneLabel = SignupLabel().then {
    $0.text = "휴대폰"
    $0.required = true
  }
  
  lazy var cellphoneTextField = UITextField().then {
    $0.placeholder = "'-' 없이 숫자만"
    $0.delegate = self
    $0.keyboardType = .phonePad
    $0.addTarget(self, action: #selector(cellphoneTextFieldEditingChanged), for: .editingChanged)
    $0.signupStyle(round: .roundedRect, clearButton: .never)
  }
  
  lazy var getCodeButton = SignupButton(
    setTitleColor: .white,
    backgroundColor: .kurlyGray3,
    borderWidth: nil,
    borderColor: nil
  ).then {
    $0.layer.cornerRadius = 5
    $0.setTitle("인증번호 받기", for: .normal)
    $0.addTarget(self, action: #selector(getCodeButtonTouched), for: .touchUpInside)
  }
  
  lazy var checkingCodeTexField = UITextField().then {
    $0.delegate = self
    $0.keyboardType = .phonePad
    $0.signupStyle(round: .roundedRect, clearButton: .whileEditing)
  }
  
  let timerInTextField = SignupLabel(textColor: .orange, font: nil).then {
    $0.isHidden = true
  }
  
  let checkingCodeButton = SignupButton(
    setTitleColor: .kurlyGray3,
    backgroundColor: .white,
    borderWidth: 1,
    borderColor: UIColor.kurlyGray3.cgColor
  ).then {
    $0.layer.cornerRadius = 5
    $0.setTitle("인증번호 확인", for: .normal)
    $0.addTarget(self, action: #selector(checkingCodeButtonTouched), for: .touchUpInside)
  }
  
  private var checkingCodeCompleteLabel = SignupLabel(textColor: nil, font: .systemFont(ofSize: 10))
  
  private let addressLabel = UILabel().then {
    $0.text = "배송주소"
  }
  
  private let addressCheckingLabel = SignupLabel(textColor: .lightGray, font: .systemFont(ofSize: 12)).then {
    $0.text = "배송 가능 여부를 확인할 수 있습니다."
  }
  
  let searchingAddressButton = SignupButton(
    setTitleColor: .white,
    backgroundColor: .kurlyMainPurple,
    borderWidth: nil,
    borderColor: nil
  ).then {
    $0.layer.cornerRadius = 5
    $0.setTitle("주소 검색", for: .normal)
    $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    $0.tintColor = .white
    $0.addTarget(self, action: #selector(searchingAddressButtonTouched), for: .touchUpInside)
  }
  
  let addressWebViewContainer = UIView().then {
    $0.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    $0.isHidden = true
  }
  
  var addressWebView: WKWebView?
  
  let addressCloseButton = UIButton(type: .system).then {
    $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    $0.tintColor = .black
    $0.addTarget(self, action: #selector(addressCloseButton(button:)), for: .touchUpInside)
  }
  
  let addressCloseView = UIView().then {
    $0.backgroundColor = .white
  }
  
  let addressTextField = UITextField().then {
    $0.signupStyle(round: .roundedRect, clearButton: .never)
    $0.addTarget(self, action: #selector(addressTextFieldDidChange(_:)), for: .editingChanged)
  }
  
  let showAddressLabel = SignupLabel(textColor: .lightGray, font: .systemFont(ofSize: 12))
  
  lazy var addressDetailTextField = UITextField().then {
    $0.signupStyle(round: .roundedRect, clearButton: .never)
    $0.placeholder = "세부주소를 입력해주세요"
    $0.delegate = self
    $0.addTarget(self, action: #selector(addressTextFieldDidChange(_:)), for: .editingChanged)
  }
  
  let limitAddressLabel = SignupLabel(textColor: .green, font: .systemFont(ofSize: 12)).then {
    $0.textAlignment = .right
  }
  
  private let birthdayLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "생년월일"
  }
  
  private let bunchBirthdayView = UIView().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
    $0.layer.cornerRadius = 5
  }
  
  lazy var birthdayYearTextField = UITextField().then {
    $0.placeholder = "YYYY"
    $0.borderStyle = .none
    $0.textAlignment = .center
    $0.delegate = self
    $0.keyboardType = .phonePad
  }
  
  private let firstSlashLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "/"
  }
  
  lazy var birthdayMonthTextField = UITextField().then {
    $0.placeholder = "MM"
    $0.borderStyle = .none
    $0.textAlignment = .center
    $0.delegate = self
    $0.keyboardType = .phonePad
  }
  
  private let secondSlashLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "/"
  }
  
  lazy var birthdayDayTextField = UITextField().then {
    $0.placeholder = "DD"
    $0.borderStyle = .none
    $0.textAlignment = .center
    $0.delegate = self
    $0.keyboardType = .phonePad
  }
  
  private let genderLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "성별"
  }
  
  private lazy var maleRoundButton = SignupButton(
    setTitleColor: nil,
    backgroundColor: nil,
    borderWidth: 1,
    borderColor: UIColor.lightGray.cgColor
  ).then {
    $0.addTarget(self, action: #selector(genderRoundButtonTouched), for: .touchUpInside)
  }
  
  private let maleLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "남자"
  }
  
  private let maleUnderline = SignupUnderLineView(borderWidth: 0.2, borderColor: UIColor.lightGray.cgColor)
  
  private let femaleRoundButton = SignupButton(
    setTitleColor: nil,
    backgroundColor: nil,
    borderWidth: 1,
    borderColor: UIColor.lightGray.cgColor
  ).then {
    $0.addTarget(self, action: #selector(genderRoundButtonTouched), for: .touchUpInside)
  }
  
  private let femaleLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "여자"
  }
  
  private let femaleUnderline = SignupUnderLineView(borderWidth: 0.2, borderColor: UIColor.lightGray.cgColor)
  
  private let noChoiceRoundButton = SignupButton(
    setTitleColor: nil,
    backgroundColor: nil,
    borderWidth: 1,
    borderColor: UIColor.lightGray.cgColor
  ).then {
    $0.addTarget(self, action: #selector(genderRoundButtonTouched), for: .touchUpInside)
  }
  
  private let noChoiceLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "선택안함"
  }
  
  private let noChoiceUnderline = SignupUnderLineView(borderWidth: 0.2, borderColor: UIColor.lightGray.cgColor)
  
  private let additionalConditionLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "추가입력 사항"
  }
  
  private let additionalExplanationLabel = SignupLabel(textColor: .gray, font: .systemFont(ofSize: 12)).then {
    $0.text = "추천인 아이디와 참여 이벤트명 중 하나마나 선택 가능합니다."
  }
  
  private let recoRoundButton = SignupButton(
    setTitleColor: nil,
    backgroundColor: nil,
    borderWidth: 1,
    borderColor: UIColor.lightGray.cgColor
  ).then {
    $0.addTarget(self, action: #selector(recoAndEventRoundButtonTouched), for: .touchUpInside)
  }
  
  private let recoIDLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "추천인 아이디"
  }
  
  private let recoUnderline = SignupUnderLineView(borderWidth: 0.2, borderColor: UIColor.lightGray.cgColor)
  
  private let eventNameRoundButton = SignupButton(
    setTitleColor: nil,
    backgroundColor: nil,
    borderWidth: 1,
    borderColor: UIColor.lightGray.cgColor
  ).then {
    $0.addTarget(self, action: #selector(recoAndEventRoundButtonTouched), for: .touchUpInside)
  }
  
  private let eventName = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "참여 이벤트명"
  }
  
  private let eventNameUnderline = SignupUnderLineView(borderWidth: 0.2, borderColor: UIColor.lightGray.cgColor)
  
  lazy var scrollView = UIScrollView().then {
    $0.delegate = self
    let gesture = UITapGestureRecognizer(target: self, action: #selector(toucheBegan))
    $0.addGestureRecognizer(gesture)
  }
  
  private let grayView = UIView().then {
    $0.backgroundColor = .kurlyGray3
  }
  
  private lazy var usingAgreement = SignupLabel(textColor: nil, font: .systemFont(ofSize: 15, weight: .bold)).then {
    $0.text = "이용약관동의"
    $0.required = true
  }
  
  var totalAgreeButton = SignupCheckBox().then {
    $0.setStatus(false)
    $0.addTarget(self, action: #selector(squareButtonTouched(button:)), for: .touchUpInside)
  }
  
  private let totalAgreeLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "전체동의"
  }
  
  let usingLawButton = SignupCheckBox().then {
    $0.setStatus(false)
    $0.addTarget(self, action: #selector(squareButtonTouched(button:)), for: .touchUpInside)
  }
  
  private let usingLawLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "이용약관"
  }
  
  private let usingLawEssentialLabel = SignupLabel(textColor: .lightGray, font: nil).then {
    $0.text = "(필수)"
  }
  
  private let usingLawSeeButton = UIButton().then {
    $0.setTitle("약관보기 >", for: .normal)
    $0.setTitleColor(.kurlyMainPurple, for: .normal)
  }
  
  let personalEssentialButton = SignupCheckBox().then {
    $0.setStatus(false)
    $0.addTarget(self, action: #selector(squareButtonTouched(button:)), for: .touchUpInside)
  }
  
  private let personalEssentialLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "개인정보처리방침"
  }
  
  private let personalEssentialNeedLabel = SignupLabel(textColor: .lightGray, font: nil).then {
    $0.text = "(필수)"
  }
  
  private let personalEssentialSeeButton = UIButton().then {
    $0.setTitle("약관보기 >", for: .normal)
    $0.setTitleColor(.kurlyMainPurple, for: .normal)
  }
  
  let personalNotEssentialButton = SignupCheckBox().then {
    $0.setStatus(false)
    $0.addTarget(self, action: #selector(squareButtonTouched(button:)), for: .touchUpInside)
  }
  
  private let personalNotEssentialLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "개인정보처리방침"
  }
  
  private let personalNotEssentialNeedLabel = SignupLabel(textColor: .lightGray, font: nil).then {
    $0.text = "(선택)"
  }
  
  private let personalNotEssentialSeeButton = UIButton().then {
    $0.setTitle("약관보기 >", for: .normal)
    $0.setTitleColor(.kurlyMainPurple, for: .normal)
  }
  
  let freeShippingButton = SignupCheckBox().then {
    $0.setStatus(false)
    $0.addTarget(self, action: #selector(squareButtonTouched(button:)), for: .touchUpInside)
  }
  
  private let freeShippingLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "무료배송, 할인쿠폰 등 혜택/정보 수신"
  }
  
  private let freeShippingCheckLabel = SignupLabel(textColor: .lightGray, font: nil).then {
    $0.text = "(선택)"
  }
  
  let smsButton = SignupCheckBox().then {
    $0.setStatus(false)
    $0.addTarget(self, action: #selector(squareButtonTouched(button:)), for: .touchUpInside)
  }
  
  private let smsLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "SMS"
  }
  
  let emailCheckButton = SignupCheckBox().then {
    $0.setStatus(false)
    $0.addTarget(self, action: #selector(squareButtonTouched(button:)), for: .touchUpInside)
  }
  
  private let emailCheckLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "이메일"
  }
  
  private let purchaseAdsView = UIImageView().then {
    $0.image = UIImage(named: "구매혜택")
  }
  
  let ageCheckButton = SignupCheckBox().then {
    $0.setStatus(false)
    $0.addTarget(self, action: #selector(squareButtonTouched(button:)), for: .touchUpInside)
  }
  
  private let ageLabel = SignupLabel(textColor: nil, font: nil).then {
    $0.text = "본인은 만 14세 이상입니다."
  }
  
  private let ageEssentialLabel = SignupLabel(textColor: .lightGray, font: nil).then {
    $0.text = "(필수)"
  }
  
  private let signupButton = UIButton().then {
    $0.setTitle("가입하기", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .kurlyMainPurple
    $0.layer.cornerRadius = 5
    $0.addTarget(self, action: #selector(signupButtonTouched(button:)), for: .touchUpInside)
  }
  
  private let lastExplainationLabel = SignupLabel(textColor: .lightGray, font: .systemFont(ofSize: 12)).then {
    $0.text = "선택항목에 동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수 \n있습니다."
    $0.textAlignment = .center
    $0.numberOfLines = 0
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    scrollView.backgroundColor = .white
    setupUI()
    layoutSubviews()
  }
  // MARK: - UIConstraint
  override func layoutSubviews() {
    [femaleRoundButton, maleRoundButton, noChoiceRoundButton, recoRoundButton, eventNameRoundButton].forEach {
      $0.makeCircleButton()
    }
  }
  
  private func setupUI() {
    [idLabel, idTextField, checkIDButton,
     secretNumberLabel, passwordTextField, checkSecretNumberLabel,
     checkPasswordTextField, nameLabel, nameTextField,
     emailLabel, emailTextFeild, cellphoneLabel,
     cellphoneTextField, getCodeButton, checkingCodeCompleteLabel,
     checkingCodeTexField, timerInTextField, checkingCodeButton,
     addressLabel, addressCheckingLabel, searchingAddressButton,
     addressTextField, showAddressLabel, addressDetailTextField, limitAddressLabel,
     birthdayLabel, genderLabel, maleRoundButton, maleLabel,
     bunchBirthdayView, femaleRoundButton, noChoiceRoundButton,
     recoRoundButton, eventNameRoundButton, recoUnderline, eventNameUnderline,
     maleUnderline, femaleUnderline, noChoiceUnderline,
     femaleLabel, noChoiceLabel, additionalConditionLabel,
     additionalExplanationLabel, recoIDLabel, eventName, grayView,
     usingAgreement, totalAgreeButton, totalAgreeLabel, usingLawButton, usingLawLabel, sameSecretNumberLabel,
     usingLawEssentialLabel, usingLawSeeButton, personalEssentialButton, personalEssentialLabel,
     tenSyllableLabel, combinationLabel, notSameTheeNumberLabel,
     personalEssentialNeedLabel, personalEssentialSeeButton, personalNotEssentialButton, personalNotEssentialLabel,
     personalNotEssentialNeedLabel, personalNotEssentialSeeButton, freeShippingButton, freeShippingLabel,
     freeShippingCheckLabel, smsButton, smsLabel, emailCheckButton, emailCheckLabel,
     purchaseAdsView, ageCheckButton, ageLabel, ageEssentialLabel,
     signupButton, lastExplainationLabel, idLimitExplanationLabel, checkingIdLabel ].forEach {
      scrollView.addSubview($0)
    }
    
    [birthdayYearTextField, firstSlashLabel,
     birthdayMonthTextField, secondSlashLabel,
     birthdayDayTextField].forEach {
      bunchBirthdayView.addSubview($0)
    }
    
    addressCloseView.addSubview(addressCloseButton)
    addressWebViewContainer.addSubview(addressCloseView)
    
    [scrollView, addressWebViewContainer].forEach {
      self.addSubview($0)
    }
    setupAddressWebView()
    
    if let addressWebView = addressWebView {
      addressWebViewContainer.addSubview(addressWebView)
    }
    
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    idLabel.snp.makeConstraints {
      $0.top.equalTo(scrollView.snp.top).offset(10)
      $0.leading.equalTo(scrollView.snp.leading).offset(10)
      $0.width.equalTo(scrollView.snp.width).multipliedBy(0.92)
    }
    
    idTextField.snp.makeConstraints {
      $0.top.equalTo(scrollView.snp.top).offset(40)
      $0.leading.equalTo(idLabel)
      $0.width.equalTo(scrollView.snp.width).multipliedBy(0.7)
      $0.height.equalTo(50)
    }
    
    checkIDButton.snp.makeConstraints {
      $0.top.equalTo(scrollView.snp.top).offset(40)
      $0.leading.equalTo(idTextField.snp.trailing).offset(10)
      $0.trailing.equalTo(idLabel)
      $0.height.equalTo(50)
    }
    
    idLimitExplanationLabel.snp.makeConstraints {
      $0.top.equalTo(idTextField.snp.bottom).offset(4)
      $0.leading.equalTo(idTextField)
      $0.trailing.equalTo(checkIDButton)
      $0.height.equalTo(0)
    }
    
    checkingIdLabel.snp.makeConstraints {
      $0.top.equalTo(idLimitExplanationLabel.snp.bottom).offset(4)
      $0.leading.equalTo(idLimitExplanationLabel)
      $0.trailing.equalTo(idLimitExplanationLabel)
      $0.height.equalTo(0)
    }

    secretNumberLabel.snp.makeConstraints {
      $0.top.equalTo(checkingIdLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(checkingIdLabel)
    }
    
    passwordTextField.snp.makeConstraints {
      $0.top.equalTo(secretNumberLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(secretNumberLabel)
      $0.height.equalTo(50)
    }
    
    tenSyllableLabel.snp.makeConstraints {
      $0.top.equalTo(passwordTextField.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(secretNumberLabel)
      $0.height.equalTo(0)
    }
    
    combinationLabel.snp.makeConstraints {
      $0.top.equalTo(tenSyllableLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(tenSyllableLabel)
      $0.height.equalTo(0)
    }
    notSameTheeNumberLabel.snp.makeConstraints {
      $0.top.equalTo(combinationLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(combinationLabel)
      $0.height.equalTo(0)
    }

    checkSecretNumberLabel.snp.makeConstraints {
      $0.top.equalTo(notSameTheeNumberLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(notSameTheeNumberLabel)
    }
    
    checkPasswordTextField.snp.makeConstraints {
      $0.top.equalTo(checkSecretNumberLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(checkSecretNumberLabel)
      $0.height.equalTo(50)
    }

    sameSecretNumberLabel.snp.makeConstraints {
      $0.top.equalTo(checkPasswordTextField.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(checkPasswordTextField)
      $0.height.equalTo(0)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(sameSecretNumberLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(checkPasswordTextField)
    }

    nameTextField.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(nameLabel)
      $0.height.equalTo(50)
    }

    emailLabel.snp.makeConstraints {
      $0.top.equalTo(nameTextField.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(nameTextField)
    }

    emailTextFeild.snp.makeConstraints {
      $0.top.equalTo(emailLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(emailLabel)
      $0.height.equalTo(50)
    }

    cellphoneLabel.snp.makeConstraints {
      $0.top.equalTo(emailTextFeild.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(emailTextFeild)
    }

    cellphoneTextField.snp.makeConstraints {
      $0.top.equalTo(cellphoneLabel.snp.bottom).offset(10)
      $0.leading.equalTo(cellphoneLabel)
      $0.width.equalTo(scrollView.snp.width).multipliedBy(0.5)
      $0.height.equalTo(50)
    }

    getCodeButton.snp.makeConstraints {
      $0.top.equalTo(cellphoneTextField)
      $0.leading.equalTo(cellphoneTextField.snp.trailing).offset(10)
      $0.trailing.equalTo(cellphoneLabel)
      $0.height.equalTo(50)
    }

    checkingCodeTexField.snp.makeConstraints {
      $0.top.equalTo(cellphoneTextField.snp.bottom).offset(10)
      $0.leading.equalTo(cellphoneTextField)
      $0.width.equalTo(scrollView.snp.width).multipliedBy(0.5)
      $0.height.equalTo(50)
    }

    timerInTextField.snp.makeConstraints {
      $0.top.bottom.equalTo(checkingCodeTexField)
      $0.trailing.equalTo(checkingCodeTexField.snp.trailing).offset(-10)
    }

    checkingCodeButton.snp.makeConstraints {
      $0.top.equalTo(getCodeButton.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(getCodeButton)
      $0.height.equalTo(50)
    }

    checkingCodeCompleteLabel.snp.makeConstraints {
      $0.top.equalTo(checkingCodeTexField.snp.bottom).offset(10)
      $0.leading.equalTo(checkingCodeTexField)
      $0.height.equalTo(0)
    }

    addressLabel.snp.makeConstraints {
      $0.top.equalTo(checkingCodeCompleteLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(cellphoneLabel)
    }

    addressCheckingLabel.snp.makeConstraints {
      $0.top.equalTo(addressLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(addressLabel)
    }

    searchingAddressButton.snp.makeConstraints {
      $0.top.equalTo(addressCheckingLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(addressCheckingLabel)
      $0.height.equalTo(50)
    }

    addressTextField.snp.makeConstraints {
      $0.top.equalTo(searchingAddressButton.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(searchingAddressButton)
      $0.height.equalTo(0)
    }

    showAddressLabel.snp.makeConstraints {
      $0.top.equalTo(addressTextField.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(addressTextField)
      $0.height.equalTo(0)
    }

    addressDetailTextField.snp.makeConstraints {
      $0.top.equalTo(showAddressLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(showAddressLabel)
      $0.height.equalTo(0)
    }

    limitAddressLabel.snp.makeConstraints {
      $0.top.equalTo(addressDetailTextField.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(addressDetailTextField)
      $0.height.equalTo(0)
    }

    birthdayLabel.snp.makeConstraints {
      $0.top.equalTo(limitAddressLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(searchingAddressButton)
    }

    bunchBirthdayView.snp.makeConstraints {
      $0.top.equalTo(birthdayLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(birthdayLabel)
      $0.height.equalTo(checkingCodeTexField)
      $0.height.equalTo(50)
    }

    birthdayYearTextField.snp.makeConstraints {
      $0.centerY.equalTo(bunchBirthdayView.snp.centerY)
      $0.leading.equalTo(bunchBirthdayView)
      $0.width.equalTo(scrollView.snp.width).dividedBy(3.2)
    }

    firstSlashLabel.snp.makeConstraints {
      $0.centerY.equalTo(bunchBirthdayView.snp.centerY)
      $0.leading.equalTo(birthdayYearTextField.snp.trailing)
      $0.width.equalTo(8)
    }

    birthdayMonthTextField.snp.makeConstraints {
      $0.centerY.equalTo(bunchBirthdayView.snp.centerY)
      $0.leading.equalTo(firstSlashLabel.snp.trailing)
      $0.width.equalTo(scrollView.snp.width).dividedBy(3.2)
    }

    secondSlashLabel.snp.makeConstraints {
      $0.centerY.equalTo(bunchBirthdayView.snp.centerY)
      $0.leading.equalTo(birthdayMonthTextField.snp.trailing)
      $0.width.equalTo(8)
    }

    birthdayDayTextField.snp.makeConstraints {
      $0.centerY.equalTo(bunchBirthdayView.snp.centerY)
      $0.leading.equalTo(secondSlashLabel.snp.trailing)
      $0.width.equalTo(scrollView.snp.width).dividedBy(3.2)
    }

    genderLabel.snp.makeConstraints {
      $0.top.equalTo(bunchBirthdayView.snp.bottom).offset(30)
      $0.leading.trailing.equalTo(searchingAddressButton)
    }

    maleRoundButton.snp.makeConstraints {
      $0.top.equalTo(genderLabel.snp.bottom).offset(30)
      $0.leading.equalTo(genderLabel).offset(4)
      $0.width.height.equalTo(20)
    }

    maleLabel.snp.makeConstraints {
      $0.top.equalTo(genderLabel.snp.bottom).offset(30)
      $0.leading.equalTo(scrollView.snp.leading).offset(44)
      $0.trailing.equalTo(genderLabel)
    }

    maleUnderline.snp.makeConstraints {
      $0.top.equalTo(maleRoundButton.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(genderLabel)
      $0.height.equalTo(1)
    }

    femaleRoundButton.snp.makeConstraints {
      $0.top.equalTo(maleUnderline.snp.bottom).offset(10)
      $0.leading.equalTo(maleRoundButton)
      $0.width.height.equalTo(20)
    }

    femaleLabel.snp.makeConstraints {
      $0.top.equalTo(femaleRoundButton)
      $0.leading.trailing.equalTo(maleLabel)
    }

    femaleUnderline.snp.makeConstraints {
      $0.top.equalTo(femaleRoundButton.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(maleUnderline)
      $0.height.equalTo(1)
    }

    noChoiceRoundButton.snp.makeConstraints {
      $0.top.equalTo(femaleUnderline.snp.bottom).offset(10)
      $0.leading.equalTo(femaleRoundButton)
      $0.width.height.equalTo(20)
    }

    noChoiceLabel.snp.makeConstraints {
      $0.top.equalTo(noChoiceRoundButton)
      $0.leading.trailing.equalTo(femaleLabel)
    }

    noChoiceUnderline.snp.makeConstraints {
      $0.top.equalTo(noChoiceRoundButton.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(femaleUnderline)
      $0.height.equalTo(1)
    }

    additionalConditionLabel.snp.makeConstraints {
      $0.top.equalTo(noChoiceUnderline.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(genderLabel)
    }

    additionalExplanationLabel.snp.makeConstraints {
      $0.top.equalTo(additionalConditionLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(additionalConditionLabel)
    }

    recoRoundButton.snp.makeConstraints {
      $0.top.equalTo(additionalExplanationLabel.snp.bottom).offset(30)
      $0.leading.equalTo(noChoiceRoundButton)
      $0.width.height.equalTo(20)
    }

    recoIDLabel.snp.makeConstraints {
      $0.top.equalTo(additionalExplanationLabel.snp.bottom).offset(30)
      $0.leading.equalTo(scrollView.snp.leading).offset(50)
      $0.trailing.equalTo(additionalExplanationLabel)
    }

    recoUnderline.snp.makeConstraints {
      $0.top.equalTo(recoIDLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(additionalExplanationLabel)
      $0.height.equalTo(1)
    }

    eventNameRoundButton.snp.makeConstraints {
      $0.top.equalTo(recoUnderline.snp.bottom).offset(20)
      $0.leading.equalTo(recoRoundButton)
      $0.width.height.equalTo(20)
    }

    eventName.snp.makeConstraints {
      $0.top.equalTo(eventNameRoundButton)
      $0.leading.trailing.equalTo(recoIDLabel)
    }

    eventNameUnderline.snp.makeConstraints {
      $0.top.equalTo(eventName.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(recoUnderline)
      $0.height.equalTo(1)
    }

    grayView.snp.makeConstraints {
      $0.top.equalTo(eventNameUnderline.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.width.equalToSuperview()
      $0.height.equalTo(10)
    }

    usingAgreement.snp.makeConstraints {
      $0.top.equalTo(grayView.snp.bottom).offset(20)
      $0.leading.equalTo(scrollView.snp.leading).offset(10)
      $0.trailing.equalTo(scrollView.snp.trailing).offset(10)
    }

    totalAgreeButton.snp.makeConstraints {
      $0.top.equalTo(usingAgreement.snp.bottom).offset(20)
      $0.leading.equalTo(usingAgreement)
      $0.width.height.equalTo(20)
    }

    totalAgreeLabel.snp.makeConstraints {
      $0.top.equalTo(totalAgreeButton)
      $0.leading.equalTo(totalAgreeButton.snp.trailing).offset(10)
    }

    usingLawButton.snp.makeConstraints {
      $0.top.equalTo(totalAgreeLabel.snp.bottom).offset(10)
      $0.leading.equalTo(totalAgreeLabel)
      $0.width.height.equalTo(20)
    }

    usingLawLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(usingLawButton)
      $0.leading.equalTo(usingLawButton.snp.trailing).offset(10)
    }

    usingLawEssentialLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(usingLawLabel)
      $0.leading.equalTo(usingLawLabel.snp.trailing).offset(10)
    }

    usingLawSeeButton.snp.makeConstraints {
      $0.top.bottom.equalTo(usingLawEssentialLabel)
      $0.trailing.equalToSuperview().offset(-20)
    }

    personalEssentialButton.snp.makeConstraints {
      $0.top.equalTo(usingLawButton.snp.bottom).offset(10)
      $0.leading.equalTo(usingLawButton)
      $0.width.height.equalTo(20)
    }

    personalEssentialLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(personalEssentialButton)
      $0.leading.equalTo(personalEssentialButton.snp.trailing).offset(10)
    }

    personalEssentialNeedLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(personalEssentialLabel)
      $0.leading.equalTo(personalEssentialLabel.snp.trailing).offset(10)
    }

    personalEssentialSeeButton.snp.makeConstraints {
      $0.top.bottom.equalTo(personalEssentialNeedLabel)
      $0.trailing.equalToSuperview().offset(-20)
    }

    personalNotEssentialButton.snp.makeConstraints {
      $0.top.equalTo(personalEssentialButton.snp.bottom).offset(10)
      $0.leading.equalTo(personalEssentialButton)
      $0.width.height.equalTo(20)
    }

    personalNotEssentialLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(personalNotEssentialButton)
      $0.leading.equalTo(personalNotEssentialButton.snp.trailing).offset(10)
    }

    personalNotEssentialNeedLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(personalNotEssentialLabel)
      $0.leading.equalTo(personalNotEssentialLabel.snp.trailing).offset(10)
    }

    personalNotEssentialSeeButton.snp.makeConstraints {
      $0.top.bottom.equalTo(personalNotEssentialLabel)
      $0.trailing.equalToSuperview().offset(-20)
    }

    freeShippingButton.snp.makeConstraints {
      $0.top.equalTo(personalNotEssentialButton.snp.bottom).offset(10)
      $0.leading.equalTo(personalNotEssentialButton)
      $0.width.height.equalTo(20)
    }

    freeShippingLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(freeShippingButton)
      $0.leading.equalTo(freeShippingButton.snp.trailing).offset(10)
    }

    freeShippingCheckLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(freeShippingLabel)
      $0.leading.equalTo(freeShippingLabel.snp.trailing).offset(10)
    }

    smsButton.snp.makeConstraints {
      $0.top.equalTo(freeShippingLabel.snp.bottom).offset(10)
      $0.leading.equalTo(freeShippingLabel)
      $0.width.height.equalTo(20)
    }

    smsLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(smsButton)
      $0.leading.equalTo(smsButton.snp.trailing).offset(10)
    }

    emailCheckButton.snp.makeConstraints {
      $0.top.bottom.equalTo(smsLabel)
      $0.leading.equalTo(smsLabel.snp.trailing).offset(50)
      $0.width.height.equalTo(20)
    }

    emailCheckLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(emailCheckButton)
      $0.leading.equalTo(emailCheckButton.snp.trailing).offset(10)
    }

    purchaseAdsView.snp.makeConstraints {
      $0.top.equalTo(emailCheckLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }

    ageCheckButton.snp.makeConstraints {
      $0.top.equalTo(purchaseAdsView.snp.bottom).offset(10)
      $0.leading.equalTo(freeShippingButton)
      $0.width.height.equalTo(20)
    }

    ageLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(ageCheckButton)
      $0.leading.equalTo(ageCheckButton.snp.trailing).offset(10)
    }

    ageEssentialLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(ageLabel)
      $0.leading.equalTo(ageLabel.snp.trailing).offset(10)
    }

    signupButton.snp.makeConstraints {
      $0.top.equalTo(ageEssentialLabel.snp.bottom).offset(30)
      $0.leading.equalTo(totalAgreeButton)
      $0.trailing.equalTo(personalNotEssentialSeeButton)
      $0.height.equalTo(50)
    }

    lastExplainationLabel.snp.makeConstraints {
      $0.top.equalTo(signupButton.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(20)
      $0.width.equalToSuperview().multipliedBy(0.92)
      $0.bottom.equalToSuperview()
    }

    addressWebViewContainer.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    addressCloseView.snp.makeConstraints {
      if let addressWebView = addressWebView {
        $0.top.equalTo(safeAreaLayoutGuide).inset(30)
        $0.leading.trailing.equalTo(addressWebView)
        $0.height.equalTo(30)
      }
    }
    
    addressCloseButton.snp.makeConstraints {
      if addressWebView != nil {
        $0.trailing.equalTo(addressCloseView.snp.trailing)
      }
    }
    
    if let addressWebView = addressWebView {
      let safeArea = addressWebViewContainer.safeAreaLayoutGuide
      addressWebView.snp.makeConstraints {
        $0.top.equalTo(safeArea).inset(50)
        $0.leading.trailing.equalTo(safeArea).inset(30)
        $0.height.equalToSuperview().multipliedBy(0.8)
      }
    }
  }
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
// MARK: - Extension, Delegate
extension SignupView {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    guard let delegate = delegate else { fatalError() }
    
    switch textField {
    case idTextField:
      return delegate.idTextField(textField, shouldChangeCharactersIn: range, replacementString: string)
    case passwordTextField:
      return delegate.passwordTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case checkPasswordTextField:
      return delegate.checkPasswordTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case nameTextField:
      return delegate.nameTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string)
    case emailTextFeild:
      return delegate.emailTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case cellphoneTextField:
      return delegate.cellphoneTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case checkingCodeTexField:
      return delegate.checkingReceivingNumberTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case birthdayYearTextField:
      return delegate.birthdayYearTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case birthdayMonthTextField:
      return delegate.birthdayMonthTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case birthdayDayTextField:
      return delegate.birthdayDayTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case addressDetailTextField:
      return delegate.addressDetailTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    default:
      fatalError()
    }
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    guard let delegate = delegate else { fatalError() }
    switch textField {
    case idTextField:
      return delegate.idTextFieldDidBeginEditing(textField)
    case passwordTextField:
      return delegate.passwordTextFieldDidBeginEditing(textField)
    case checkPasswordTextField:
      return delegate.checkPasswordTextFieldDidBeginEditing(textField)
    default:
      return print("")
    }
  }
  
  func idTextFieldOpenHiddenMessage() {
    idLimitExplanationLabel.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    checkingIdLabel.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    secretNumberLabel.snp.updateConstraints {
      $0.top.equalTo(checkingIdLabel.snp.bottom).offset(30)
    }
  }
  
  func secretTextFeildOpenHiddenMessage() {
    tenSyllableLabel.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    combinationLabel.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    notSameTheeNumberLabel.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    checkSecretNumberLabel.snp.updateConstraints {
      $0.top.equalTo(notSameTheeNumberLabel.snp.bottom).offset(30)
    }
  }
  
  func checkSecretNumberTextFeildOpenHiddenMessage() {
    sameSecretNumberLabel.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    nameLabel.snp.updateConstraints {
      $0.top.equalTo(sameSecretNumberLabel.snp.bottom).offset(30)
    }
  }
  
  func checkingCodeCompleteLabelOpenHiddenMessage(text: String, textColor: UIColor) {
    checkingCodeCompleteLabel.text = text
    checkingCodeCompleteLabel.textColor = textColor
    checkingCodeCompleteLabel.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    addressLabel.snp.updateConstraints {
      $0.top.equalTo(checkingCodeCompleteLabel.snp.bottom).offset(30)
    }
  }
  
  @objc func idTextFieldEditingChanged(_ textField: UITextField) {
    guard
      let delegate = delegate,
      let text = textField.text
      else { fatalError() }
    
    delegate.idTextFieldEditingChanged(textField, text: text)
  }
  
  @objc func checkIDButtonTouched(_ button: UIButton) {
    delegate?.checkIDButtonTouched(button)
  }
  
  @objc func passwordTextFieldEditingChanged(_ textField: UITextField, text: String) {
    guard
      let delegate = delegate,
      let text = textField.text
      else { fatalError() }
    delegate.passwordTextFieldEditingChanged(textField, text: text)
  }
  
  @objc func checkName(_ textField: UITextField, text: String) {
    guard
      let delegate = delegate,
      let text = textField.text
      else { fatalError() }
    delegate.checkName(textField, text: text)
  }
  
  @objc func checkPasswordTextFieldEditingChanged(_ textField: UITextField, text: String) {
    guard
      let delegate = delegate,
      let text = textField.text
      else { fatalError() }
    delegate.checkPasswordTextFieldEditingChanged(textField, text: text)
  }
  
  @objc func cellphoneTextFieldEditingChanged(_ textField: UITextField, text: String) {
    guard
      let delegate = delegate,
      let text = textField.text
      else { fatalError() }
    delegate.cellphoneTextFieldEditingChanged(textField, text: text)
  }
  
  @objc func emailTextFeildEditingChanged(_ textField: UITextField, text: String) {
    guard
      let delegate = delegate,
      let text = textField.text
      else { fatalError() }
    delegate.emailTextFeildEditingChanged(textField, text: text)
  }
  
  @objc func getCodeButtonTouched() {
    delegate?.receivingCellphoneNumberButtonTouched()
  }
  
  func activateGetCodeButton(_ able: Bool) {
    getCodeButton.isEnabled = able
    able ? (getCodeButton.backgroundColor = .kurlyMainPurple) : (getCodeButton.backgroundColor = .lightGray)
  }
  
  func setCheckingCodeButton(buttonColor: UIColor) {
    checkingCodeButton.layer.borderColor = buttonColor.cgColor
    checkingCodeButton.setTitleColor(buttonColor, for: .normal)
  }
  
  @objc func checkingCodeButtonTouched() {
    delegate?.checkingCodeButtonTouched()
  }
  
  @objc func searchingAddressButtonTouched(button: UIButton) {
    delegate?.searchingAddressButtonTouched(button)
  }
  
  func addressButtonTouchedOpenTextField() {
    addressTextField.snp.updateConstraints {
      $0.height.equalTo(50)
    }
    showAddressLabel.snp.updateConstraints {
      $0.height.equalTo(12)
    }
    addressDetailTextField.snp.updateConstraints {
      $0.height.equalTo(50)
    }
    limitAddressLabel.snp.updateConstraints {
      $0.height.equalTo(12)
    }
    birthdayLabel.snp.updateConstraints {
      $0.top.equalTo(limitAddressLabel.snp.bottom).offset(30)
    }
  }
  
  @objc func genderRoundButtonTouched(button: UIButton) {
    let buttons = [maleRoundButton, femaleRoundButton, noChoiceRoundButton]
      .filter { $0 != button }
    delegate?.genderRoundButtonTouched(button: button, noChoice: buttons)
  }
  
  @objc func recoAndEventRoundButtonTouched(button: UIButton) {
    let buttons = [recoRoundButton, eventNameRoundButton]
      .filter { $0 != button }
    delegate?.recoAndEventRoundButtonTouched(button: button, eventButton: buttons)
  }
  
  @objc func squareButtonTouched(button: UIButton) {
    let buttons: [UIButton] = [
      totalAgreeButton,
      usingLawButton,
      personalEssentialButton,
      personalNotEssentialButton,
      freeShippingButton,
      smsButton,
      emailCheckButton,
      ageCheckButton
    ]
    delegate?.squareButtonTouched(button: button, leftButtons: buttons)
  }
  
  @objc func signupButtonTouched(button: UIButton) {
    delegate?.signupButtonTouched(button: button)
  }
  
  @objc private func addressTextFieldDidChange(_ addressTextField: UITextField) {
    delegate?.addressTextField(
      self.addressTextField,
      self.addressDetailTextField,
      self.addressTextField.text ?? "",
      self.addressDetailTextField.text ?? ""
    )
  }
  
  private func setupAddressWebView() {
    let contentController = WKUserContentController()
    contentController.add(self, name: "callBackHandler")
    
    let config = WKWebViewConfiguration()
    config.userContentController = contentController
    
    self.addressWebView = WKWebView(frame: .zero, configuration: config)
  }
  
  @objc func addressCloseButton(button: UIButton) {
    delegate?.addressCloseButton(button: button)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    delegate?.textFieldShouldReturn(textField) ?? true
  }
  
  @objc func toucheBegan() {
    delegate?.toucheBegan()
  }
}
extension SignupView: WKScriptMessageHandler {
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    delegate?.userContentController(userContentController, didReceive: message)
  }
}

extension SignupView: UIScrollViewDelegate {}
extension SignupView: UITextFieldDelegate {}
