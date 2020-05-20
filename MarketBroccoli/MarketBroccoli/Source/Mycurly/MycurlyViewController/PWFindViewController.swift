//
//  PWFindViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class PWFindViewController: UIViewController {
  private lazy var PWFView = PWFindView().then {
    $0.delegate = self
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
    setupUI()
  }
  
  func setupUI() {
    view.addSubview(PWFView)
    let guide = view.safeAreaLayoutGuide
    PWFView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(guide)
      $0.bottom.equalToSuperview()
    }
  }
  
  private func setupNavigation() {
    self.navigationController?.navigationBar.barTintColor = .white
    self.navigationItem.title = "비밀번호 찾기"
  }
}
extension PWFindViewController: PWFindViewDeleate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == PWFView.nameTextField {
      PWFView.idTextField.becomeFirstResponder()
    } else if textField == PWFView.idTextField {
      PWFView.emailTextField.becomeFirstResponder()
    } else {
      PWFView.emailTextField.resignFirstResponder()
    }
    return true
  }
}
