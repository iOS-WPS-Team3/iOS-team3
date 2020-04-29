//
//  SignupCheckBox.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/31.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
protocol SignupCheckBoxDelegate: class {
  func checkBoxTouched(_ checkBox: SignupCheckBox, _ isChecked: Bool)
}
class SignupCheckBox: UIButton {
  // MARK: - Properties
  weak var delegate: SignupCheckBoxDelegate?
  private var isChecked: Bool {
    didSet {
      isChecked ?
        setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal) :
        setImage(UIImage(systemName: "square"), for: .normal)
    }
  }
  // MARK: Life Cycle
  private override init(frame: CGRect) {
    isChecked = true
    super.init(frame: frame)
    setupAttribute()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Setup UI
  private func setupAttribute() {
    self.do {
      $0.contentMode = .scaleAspectFit
      $0.tintColor = .kurlyMainPurple
      $0.addTarget(self, action: #selector(checkBoxTouched(_:)), for: .touchUpInside)
    }
  }
  // MARK: - Action Handler
  @objc
  private func checkBoxTouched(_ checkBox: SignupCheckBox) {
    isChecked.toggle()
    delegate?.checkBoxTouched(checkBox, isChecked)
  }
  // MARK: - Elment Control
  func setStatus(_ checked: Bool) {
    self.isChecked = checked
  }
}
