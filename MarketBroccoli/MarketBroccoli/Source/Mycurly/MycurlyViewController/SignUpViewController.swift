//  SignUpViewController.swift
//  MarketBroccoli
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.

import Alamofire
import UIKit
import WebKit

class SignUpViewController: UIViewController {
  private lazy var signupView = SignupView().then {
    $0.delegate = self
  }
  var password = [String]()
  
  let agreement = Agreement()
  
  var essentialInfo: [Signup: Bool] = [
    .identification: false,
    .password: false,
    .passwordCheck: false,
    .name: false,
    .email: false,
    .cellphone: false,
    .cellphoneCheck: false,
    .usingLaw: false,
    .personalInfo: false,
    .ageLimit: false
  ]
  
  private var leftTime = 300 {
    didSet {
      signupView.timerInTextField.text = timeFormatted(leftTime)
    }
  }
  private var isAuthorized = true
  
  private var timer = Timer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    moveKeyboard()
    setupNavigationBackButton()
  }
  
  private func setupUI() {
    [signupView].forEach {
      self.view.addSubview($0)
    }
    
    signupView.backgroundColor = .white
    self.view.backgroundColor = .white
    signupView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func selectedAllButton() {
    agreement.usingLaw = true
    agreement.personalEseesntial = true
    agreement.personalNotEssential = true
    agreement.freeShipping = true
    agreement.sms = true
    agreement.emailCheck = true
    agreement.ageCheck = true
    signupView.totalAgreeButton.setStatus(true)
    signupView.usingLawButton.setStatus(true)
    signupView.personalEssentialButton.setStatus(true)
    signupView.personalNotEssentialButton.setStatus(true)
    signupView.freeShippingButton.setStatus(true)
    signupView.smsButton.setStatus(true)
    signupView.emailCheckButton.setStatus(true)
    signupView.ageCheckButton.setStatus(true)
  }
  
  func notSelectedAllButton() {
    agreement.usingLaw = false
    agreement.personalEseesntial = false
    agreement.personalNotEssential = false
    agreement.freeShipping = false
    agreement.sms = false
    agreement.emailCheck = false
    agreement.ageCheck = false
    signupView.totalAgreeButton.setStatus(false)
    signupView.usingLawButton.setStatus(false)
    signupView.personalEssentialButton.setStatus(false)
    signupView.personalNotEssentialButton.setStatus(false)
    signupView.freeShippingButton.setStatus(false)
    signupView.smsButton.setStatus(false)
    signupView.emailCheckButton.setStatus(false)
    signupView.ageCheckButton.setStatus(false)
  }
}
// MARK: - Action
extension SignUpViewController: SignupViewDelegate {
  private func setupNavigationBackButton() {
    let button = UIButton(type: .system).then {
      $0.tintColor = .black
      $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
      $0.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
    }
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
  }
  
  @objc private func buttonTouched() {
    navigationController?.popViewController(animated: true)
  }
  
  private func moveKeyboard() {
    _ = NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardDidShowNotification,
      object: nil,
      queue: OperationQueue.main) { (noti) in
        if let frameValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
          let keyboardFrame = frameValue.cgRectValue
          self.signupView.scrollView.snp.updateConstraints {
            $0.bottom.equalToSuperview().inset(keyboardFrame.height)
          }
          self.view.layoutIfNeeded()
        }
    }
    _ = NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardWillHideNotification,
      object: nil,
      queue: OperationQueue.main) { _ in
        self.signupView.scrollView.snp.updateConstraints {
          $0.bottom.equalToSuperview()
        }
        self.view.layoutIfNeeded()
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case signupView.idTextField:
      self.signupView.passwordTextField.becomeFirstResponder()
    case signupView.passwordTextField:
      self.signupView.checkPasswordTextField.becomeFirstResponder()
    case signupView.checkPasswordTextField:
      self.signupView.nameTextField.becomeFirstResponder()
    case signupView.nameTextField:
      self.signupView.emailTextFeild.becomeFirstResponder()
    case signupView.emailTextFeild:
      signupView.cellphoneTextField.becomeFirstResponder()
    case signupView.addressDetailTextField:
      signupView.addressDetailTextField.resignFirstResponder()
    case signupView.birthdayYearTextField:
      signupView.birthdayMonthTextField.becomeFirstResponder()
    case signupView.birthdayMonthTextField:
      signupView.birthdayDayTextField.becomeFirstResponder()
    case signupView.birthdayDayTextField:
      signupView.birthdayDayTextField.resignFirstResponder()
    default:
      break
    }
    
    return true
  }
  
  func signupButtonTouched(button: UIButton) {
    if !essentialInfo.values.contains(false) {
      let user = User(
        userName: signupView.idTextField.text ?? "",
        email: signupView.emailTextFeild.text ?? "",
        name: signupView.nameTextField.text ?? "",
        password: signupView.passwordTextField.text ?? "",
        address: Address(
          jibunAddress: signupView.addressTextField.text ?? "",
          roadAddress: signupView.showAddressLabel.text ?? "",
          zipCode: "123456"),
        mobile: signupView.cellphoneTextField.text ?? ""
      )
      
      print(user)
      AF.request(
        "http://15.164.49.32/accounts/",
        method: .post,
        parameters: user,
        encoder: JSONParameterEncoder.default,
        headers: ["Content-Type": "application/json"]
      )
        .validate(statusCode: 200..<300)
        .responseData { response in
          switch response.result {
          case .success(let data):
            print("회원가입 누르기:\(data)")
            let alertController = UIAlertController(
              title: nil,
              message: "회원가입을 축하드립니다!\n당신의 일상에 컬리를 더해 보세요",
              preferredStyle: .alert
            )
            let alert = UIAlertAction(title: "확인", style: .default) { _ in
              self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(alert)
            self.present(alertController, animated: true)
          case .failure(let error):
            print("error :", error)
          }
      }
    } else if essentialInfo[.identification] == false && (signupView.idTextField.text ?? "").isEmpty {
      alert(message: "아이디를 입력해 주세요")
    } else if essentialInfo[.identification] == false {
      alert(message: "아이디를 확인해 주세요")
    } else if essentialInfo[.password] == false {
      alert(message: "비밀번호를 입력해주세요")
    } else if essentialInfo[.passwordCheck] == false {
      alert(message: "비밀번호확인이 일치하지 않습니다")
    } else if essentialInfo[.name] == false {
      alert(message: "(필수)이름을(를) 입력하세요.")
    } else if essentialInfo[.email] == false {
      alert(message: "(필수)이메일을(를) 입력하세요.")
    } else if essentialInfo[.cellphone] == false {
      alert(message: "(필수)휴대폰을(를) 입력하세요.")
    } else if essentialInfo[.cellphoneCheck] == false {
      alert(message: "(필수)인증번호을(를) 입력하세요.")
    } else if essentialInfo[.usingLaw] == false {
      alert(message: "필수 이용약관에 동의해주세요")
    } else if essentialInfo[.personalInfo] == false {
      alert(message: "개인정보처리방침에 동의해주세요")
    } else if essentialInfo[.ageLimit] == false {
      alert(message: "만 14세 이상에 동의해주세요")
    }
  }

  func addressTextField(
    _ addressTextField: UITextField,
    _ detailAddressTextField: UITextField,
    _ address: String,
    _ detailAddress: String
  ) {
    signupView.limitAddressLabel.text = "\(address.count + detailAddress.count)자 / 85자"
  }

  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    guard
      let addressData = message.body as? [String: String],
      let zonecode = addressData["zonecode"],
      let roadAddress = addressData["roadAddress"],
      let jibunAddress = addressData["jibunAddress"]
      else { return signupView.addressWebViewContainer.isHidden = true }

    print(zonecode)
    print(addressData)

    signupView.addressWebViewContainer.isHidden = true
    signupView.addressTextField.text = jibunAddress
    signupView.showAddressLabel.text = roadAddress
    signupView.addressButtonTouchedOpenTextField()
    signupView.searchingAddressButton.setTitle("주소 재검색", for: .normal)
    signupView.searchingAddressButton.setTitleColor(.kurlyPurple1, for: .normal)
    signupView.searchingAddressButton.backgroundColor = .white
    signupView.searchingAddressButton.tintColor = .kurlyPurple1
    signupView.searchingAddressButton.layer.borderColor = UIColor.kurlyPurple1.cgColor
    signupView.searchingAddressButton.layer.borderWidth = 1
    let addressCount = (signupView.addressTextField.text ?? "").count
    let detailAddressCount = (signupView.addressDetailTextField.text ?? "").count
    signupView.limitAddressLabel.text = "\(addressCount + detailAddressCount)자 / 85자"
  }

  func alert(message: String) {
    let alertController = UIAlertController(
      title: nil,
      message: message,
      preferredStyle: .alert
    )
    let warning = UIAlertAction(title: "확인", style: .default) {_ in
    }
    alertController.addAction(warning)
    present(alertController, animated: true)
  }

  func squareButtonTouched(button: UIButton, leftButtons leftButton: [UIButton]) {
    if button == signupView.totalAgreeButton {
      agreement.total ? notSelectedAllButton() : selectedAllButton()
      essentialInfo[.usingLaw]?.toggle()
      essentialInfo[.personalInfo]?.toggle()
      essentialInfo[.ageLimit]?.toggle()
    } else if button == signupView.usingLawButton {
      essentialInfo[.usingLaw]?.toggle()
      agreement.usingLaw.toggle()
      signupView.usingLawButton.setStatus(agreement.usingLaw)
      signupView.totalAgreeButton.setStatus(agreement.total)
    } else if button == signupView.personalEssentialButton {
      essentialInfo[.personalInfo]?.toggle()
      agreement.personalEseesntial.toggle()
      signupView.personalEssentialButton.setStatus(agreement.personalEseesntial)
      signupView.totalAgreeButton.setStatus(agreement.total)
    } else if button == signupView.personalNotEssentialButton {
      agreement.personalNotEssential.toggle()
      signupView.personalNotEssentialButton.setStatus(agreement.personalNotEssential)
      signupView.totalAgreeButton.setStatus(agreement.total)
    } else if button == signupView.freeShippingButton {
      agreement.freeShipping.toggle()
      signupView.freeShippingButton.setStatus(agreement.freeShipping)
      signupView.smsButton.setStatus(agreement.freeShipping)
      signupView.emailCheckButton.setStatus(agreement.freeShipping)
      signupView.totalAgreeButton.setStatus(agreement.total)
    } else if button == signupView.smsButton {
      agreement.sms.toggle()
      agreement.freeShipping = agreement.sms && agreement.emailCheck

      signupView.smsButton.setStatus(agreement.sms)
      signupView.freeShippingButton.setStatus(agreement.freeShipping)
      signupView.totalAgreeButton.setStatus(agreement.total)
    } else if button == signupView.emailCheckButton {
      agreement.emailCheck.toggle()
      agreement.freeShipping = agreement.sms && agreement.emailCheck

      signupView.emailCheckButton.setStatus(agreement.emailCheck)
      signupView.freeShippingButton.setStatus(agreement.freeShipping)
      signupView.totalAgreeButton.setStatus(agreement.total)
    } else if button == signupView.ageCheckButton {
      agreement.ageCheck.toggle()
      essentialInfo[.ageLimit]?.toggle()
      signupView.ageCheckButton.setStatus(agreement.ageCheck)
      signupView.totalAgreeButton.setStatus(agreement.total)
    }
  }

  func recoAndEventRoundButtonTouched(button: UIButton, eventButton: [UIButton]) {
    let borderWidth: CGFloat = 6
    button.layer.borderColor = UIColor.kurlyMainPurple.cgColor
    button.layer.borderWidth = borderWidth
    eventButton.forEach {
      $0.layer.borderWidth = 1
      $0.layer.borderColor = UIColor.lightGray.cgColor
    }
  }

  func genderRoundButtonTouched(button: UIButton, noChoice: [UIButton]) {
    let borderWidth: CGFloat = 6
    button.layer.borderColor = UIColor.kurlyMainPurple.cgColor
    button.layer.borderWidth = borderWidth
    noChoice.forEach {
      $0.layer.borderWidth = 1
      $0.layer.borderColor = UIColor.lightGray.cgColor
    }
  }

  func addressCloseButton(button: UIButton) {
    signupView.addressWebViewContainer.isHidden = true
    view.endEditing(true)
  }

  func searchingAddressButtonTouched(_ button: UIButton) {
    signupView.addressWebViewContainer.isHidden = false

    guard
      let url = URL(string: "https://martinolee.github.io/postcode/"),
      let addressWebView = signupView.addressWebView
      else { return }

    let urlRequest = URLRequest(url: url)

    addressWebView.load(urlRequest)
  }

  func checkingCodeButtonTouched() {
    let mobileNumber = signupView.cellphoneTextField.text ?? ""
    let checkingCode = signupView.checkingCodeTexField.text ?? ""

    AF.request(
      "http://15.164.49.32/accounts/m-token-auth/",
      method: .post,
      parameters: UserMobileCode(userMobile: mobileNumber, token: checkingCode),
      encoder: JSONParameterEncoder.default,
      headers: ["Content-Type": "application/json"]
    ).validate(statusCode: 200..<300)
      .responseData { response in
        switch response.result {
        case .success(let data):
          self.signupView.checkingCodeTexField.isEnabled = false
          self.signupView.checkingCodeButton.isEnabled = false
          self.signupView.checkingCodeCompleteLabelOpenHiddenMessage(text: "인증번호 확인완료.", textColor: .green)
          self.signupView.activateGetCodeButton(false)
          self.isAuthorized = false
          self.signupView.timerInTextField.isHidden = true
          self.essentialInfo[.cellphoneCheck] = true

          guard let decodedData = try? JSONDecoder().decode(
            UserMobileCodeResponse.self,
            from: data
            ) else { return }
          print(decodedData)
        case .failure(let error):
          self.signupView.checkingCodeCompleteLabelOpenHiddenMessage(text: "인증번호를 확인해주세요", textColor: .orange)
          self.essentialInfo[.cellphoneCheck] = false
          print(error.localizedDescription)
        }
    }
  }

  func receivingCellphoneNumberButtonTouched() {
    let text = signupView.cellphoneTextField.text ?? ""
    if hasCellphoneNumber(text: text) {
      AF.request(
        "http://15.164.49.32/accounts/m-token-create/",
        method: .post,
        parameters: UserMobile(userMobile: text),
        encoder: JSONParameterEncoder.default,
        headers: ["Content-Type": "application/json"]
      ).validate(statusCode: 200..<300)
        .responseData { response in
          switch response.result {
          case .success(let data):
            self.signupView.timerInTextField.isHidden = false
            self.signupView.activateGetCodeButton(false)
            self.signupView.setCheckingCodeButton(buttonColor: .kurlyMainPurple)
            self.startTimer()
            self.signupView.getCodeButton.backgroundColor = .lightGray
            self.signupView.cellphoneTextField.isEnabled = false
            self.essentialInfo[.cellphone] = true
            guard let decodedData = try? JSONDecoder().decode(
              UserMobileResponse.self,
              from: data
              ) else { return }
            print(decodedData)
          case .failure(let error):
            self.alert(message: "이미 가입된 번호입니다.")
            print(error.localizedDescription)
          }
      }
    } else {
      essentialInfo[.cellphone] = false
      alert(message: "잘못된 휴대폰 번호 입니다. 확인후 다시 시도 해 주세요")
    }
  }

  func startTimer() {
    timer = Timer.scheduledTimer(
      timeInterval: 1,
      target: self,
      selector: #selector(update),
      userInfo: nil, repeats: true
    )
  }

  @objc func update() {
    leftTime -= 1

    if leftTime == 0 && isAuthorized {
      endTimer()
      let alertController = UIAlertController(
        title: nil,
        message: "인증 제한 시간이 지났습니다",
        preferredStyle: .alert
      )
      let warning = UIAlertAction(title: "확인", style: .default) { _ in
        self.signupView.timerInTextField.isHidden = true
        self.signupView.setCheckingCodeButton(buttonColor: .lightGray)
        self.signupView.getCodeButton.backgroundColor = .kurlyMainPurple
        self.signupView.activateGetCodeButton(true)
        self.leftTime = 5
        self.signupView.cellphoneTextField.isEnabled = true
      }
      alertController.addAction(warning)
      present(alertController, animated: true)
    }
  }

  func timeFormatted(_ totalSeconds: Int) -> String {
    let seconds: Int = totalSeconds % 60
    let minutes: Int = (totalSeconds / 60) % 60
    //     let hours: Int = totalSeconds / 3600
    return String(format: "%02d:%02d", minutes, seconds)
  }

  func endTimer() {
    timer.invalidate()
  }

  func emailTextFeildEditingChanged(_ textField: UITextField, text: String) {
    if isEmail(email: text) {
      textField.layer.borderColor = UIColor.green.cgColor
      essentialInfo[.email] = true
    } else {
      textField.layer.borderColor = UIColor.orange.cgColor
      essentialInfo[.email] = false
    }
  }

  func cellphoneTextFieldEditingChanged(_ textField: UITextField, text: String) {
    if text.count > 9 {
      signupView.getCodeButton.backgroundColor = .kurlyMainPurple
      signupView.getCodeButton.isEnabled = true
    } else {
      signupView.getCodeButton.backgroundColor = .gray
      signupView.getCodeButton.isEnabled = false
    }
  }

  private func hasCellphoneNumber(text: String) -> Bool {
    do {
      let regex = try NSRegularExpression(
        pattern: "^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$",
        options: .caseInsensitive
      )
      if regex.firstMatch(
        in: text,
        options: NSRegularExpression.MatchingOptions.reportCompletion,
        range: NSRange(location: 0, length: text.count)) != nil {
        return true
      }
    } catch {
      print(error.localizedDescription)
      return false
    }
    return false
  }

  func validateEmail() -> Bool {
    let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
    let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return predicate.evaluate(with: self)
  }

  func checkName(_ textField: UITextField, text: String) {
    if text.count >= 1 {
      essentialInfo[.name] = true
    } else {
      essentialInfo[.name] = false
    }
  }

  func checkPasswordTextFieldEditingChanged(_ textField: UITextField, text: String) {
    print("checkSecretNumberTextFeildEditingChanged")
    if text == (signupView.passwordTextField.text ?? "") {
      signupView.sameSecretNumberLabel.textColor = .green
      print("true")
      essentialInfo[.passwordCheck] = true
    } else {
      signupView.sameSecretNumberLabel.textColor = .orange
      essentialInfo[.passwordCheck] = false
    }
  }

  func passwordTextFieldEditingChanged(_ textField: UITextField, text: String) {
    if text.count >= 10 &&
      hasSpecialWords(text: text) &&
      !checkContinuousNumber(text) {
      essentialInfo[.password] = true
    } else {
      essentialInfo[.password] = false
    }

    if text.count >= 10 {
      signupView.tenSyllableLabel.textColor = .green
    } else {
      signupView.tenSyllableLabel.textColor = .orange
    }

    if hasSpecialWords(text: text) {
      signupView.combinationLabel.textColor = .green
    } else {
      signupView.combinationLabel.textColor = .orange
    }

    let isContinuous = checkContinuousNumber(text)

    if !isContinuous {
      signupView.notSameTheeNumberLabel.textColor = .green
    } else {
      signupView.notSameTheeNumberLabel.textColor = .orange
    }
    if text == signupView.checkPasswordTextField.text ?? "" {
      signupView.sameSecretNumberLabel.textColor = .green
      essentialInfo[.passwordCheck] = true
    } else {
      print(signupView.checkingCodeTexField.text ?? "")
      signupView.sameSecretNumberLabel.textColor = .orange
      essentialInfo[.passwordCheck] = false
    }
  }

  func checkWidth(_ text: String) -> Bool {
    return text.count > 9
  }

  func checkContinuousNumber(_ text: String) -> Bool {
    let continuousSet = Array(0...9).map { "\($0)\($0)\($0)" }
    var isContinuous = false
    continuousSet.forEach {
      if text.contains($0) {
        isContinuous = true
        return
      }
    }
    return isContinuous
  }

  func checkIDButtonTouched(_ button: UIButton) {
    guard let text = signupView.idTextField.text else { return }
    if text.count >= 6 && hasOnlyAlphabetAndNumber(text: text) {
      AF.request(
        "http://15.164.49.32/accounts/duplicates/",
        method: .post,
        parameters: UserName(userName: text),
        encoder: JSONParameterEncoder.default,
        headers: ["Content-Type": "application/json"]
      ).validate(statusCode: 200..<300)
        .responseData { response in
          switch response.result {
          case .success(let data):
            self.signupView.checkingIdLabel.textColor = .green
            self.essentialInfo[.identification] = true
            self.signupView.idTextField.isEnabled = false
            self.signupView.checkIDButton.isEnabled = false
            button.backgroundColor = .lightGray
            self.alert(message: "사용하실 수 있는 아이디입니다!")
            guard let decodedData = try? JSONDecoder().decode(UserNameResponse.self, from: data) else { return }
            print(decodedData)
          case .failure(let error):
            print(error.localizedDescription)
            self.alert(message: "\(text)이 이미 존재합니다.")
          }
      }
    } else {
      signupView.checkingIdLabel.textColor = .orange
      essentialInfo[.identification] = false
      alert(message: "6자 이상의 영문 혹은 영문과 숫자를 조합으로 입력해 주세요")
    }
  }

  private func isEmail (email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
  }

  private func hasOnlyAlphabetAndNumber(text: String) -> Bool {
    do {
      let regex = try NSRegularExpression(
        pattern: "^(?!(?:[0-9]+)$)([a-zA-Z]|[0-9a-zA-Z]){4,}$",
        options: .caseInsensitive)
      if regex.firstMatch(
        in: text,
        options: NSRegularExpression.MatchingOptions.reportCompletion,
        range: NSRange(location: 0, length: text.count)) != nil {
        return true
      }
    } catch {
      print(error.localizedDescription)
      return false
    }
    return false
  }

  private func hasSpecialWords(text: String) -> Bool {
    do {
      let regex = try NSRegularExpression(
        pattern: "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{10,16}$",
        options: .caseInsensitive)
      if regex.firstMatch(
        in: text,
        options: NSRegularExpression.MatchingOptions.reportCompletion,
        range: NSRange(location: 0, length: text.count)) != nil {
        return true
      }
    } catch {
      print(error.localizedDescription)
      return false
    }
    return false
  }

  func idTextFieldEditingChanged(_ textField: UITextField, text: String) {
    if text.count >= 6 && hasOnlyAlphabetAndNumber(text: text) {
      signupView.idLimitExplanationLabel.textColor = .green
    } else {
      signupView.idLimitExplanationLabel.textColor = .orange
    }
  }

  func checkPasswordTextFieldDidBeginEditing(_ textField: UITextField) {
    signupView.checkSecretNumberTextFeildOpenHiddenMessage()
  }

  func passwordTextFieldDidBeginEditing(_ textField: UITextField) {
    signupView.secretTextFeildOpenHiddenMessage()
  }

  func idTextFieldDidBeginEditing(_ textField: UITextField) {
    signupView.idTextFieldOpenHiddenMessage()
  }

  func toucheBegan() {
    self.view.endEditing(true)
  }

  func idTextField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 12
  }

  func passwordTextField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String) -> Bool {
    textField.isSecureTextEntry = true
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 16
  }

  func checkPasswordTextField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String) -> Bool {
    textField.isSecureTextEntry = true
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 16
  }

  func nameTextField(_ textField: UITextField,
                     shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 12
  }

  func emailTextField(_ textField: UITextField,
                      shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 30
  }

  func cellphoneTextField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 13
  }

  func checkingReceivingNumberTextField(_ textField: UITextField,
                                        shouldChangeCharactersIn range: NSRange,
                                        replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 6
  }

  func birthdayYearTextField(_ textField: UITextField,
                             shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""

      let allowedCharacters = CharacterSet.decimalDigits
      let characterSet = CharacterSet(charactersIn: string)

    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 4 && allowedCharacters.isSuperset(of: characterSet)
  }

  func birthdayMonthTextField(_ textField: UITextField,
                              shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    let allowedCharacters = CharacterSet.decimalDigits
    let characterSet = CharacterSet(charactersIn: string)

    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 2 && allowedCharacters.isSuperset(of: characterSet)
  }

  func birthdayDayTextField(_ textField: UITextField,
                            shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let allowedCharacters = CharacterSet.decimalDigits
    let characterSet = CharacterSet(charactersIn: string)

    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 2 && allowedCharacters.isSuperset(of: characterSet)
  }

  func addressDetailTextField(_ textField: UITextField,
                              shouldChangeCharactersIn range: NSRange,
                              replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

    guard let addressTextFieldText = signupView.addressTextField.text else { fatalError() }

    return (updatedText.count + addressTextFieldText.count) <= 85
  }
}
