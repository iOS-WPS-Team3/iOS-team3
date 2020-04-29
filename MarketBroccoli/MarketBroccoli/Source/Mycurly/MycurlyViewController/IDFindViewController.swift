//
//  IDFindViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import SnapKit

class IDFindViewController: UIViewController {
  private lazy var IDFView = IDFindView().then {
    $0.delegate = self
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    setupUI()
  }
  
  func setupUI() {
    view.addSubview(IDFView)
    let guide = view.safeAreaLayoutGuide
    
    IDFView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(guide)
      $0.bottom.equalToSuperview()
    }
  }
  
  private func setNavigation() {
    self.navigationController?.navigationBar.barTintColor = .white
    self.navigationItem.title = "아이디 찾기"
  }
}
extension IDFindViewController: IDFindViewDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == IDFView.nameTextField {
      IDFView.emailTextField.becomeFirstResponder()
    } else {
      IDFView.emailTextField.resignFirstResponder()
    }
    return true
  }
}
