//
//  SettingsViewController.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.

import UIKit
class SettingsViewController: UIViewController {
  var isLogin = false {
    didSet {
      myKurlyTableView.reloadData()
    }
  }
  
  private let settingOptBeforeLogin = [
    ["Login"],
    ["비회원 주문 조회"],
    ["배송 안내", "공지사항", "자주하는 질문", "고객센터", "이용안내", "컬리소개"],
    ["알림설정"]
  ]
  
  private let settingOptAfterLogin = [
    ["유저 정보"],
    ["적립금", "쿠폰", "친구초대"],
    ["주문 내역", "상품 후기", "상품 문의", "1:1 문의", "대량주문 문의"],
    ["배송 안내", "공지사항", "자주하는 질문", "고객센터", "이용안내", "컬리소개", "자주하는 질문", "고객센터", "이용안내", "컬리소개", "컬리패스"],
    ["개인정보 수정", "알림설정"],
    ["로그아웃"]
  ]
  
  private lazy var myKurlyTableView = UITableView(frame: .zero, style: .grouped).then {
    $0.sectionFooterHeight = 10
    $0.allowsSelection = true
    $0.dataSource = self
    $0.delegate = self
    $0.register(cell: SettingsTableViewCell.self)
    $0.register(cell: UserInfoTableViewCell.self)
    $0.register(UITableViewCell.self, forCellReuseIdentifier: "Detail")
    $0.backgroundColor = .kurlyGray3
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    self.setupBroccoliNavigationBar(title: "마이컬리")
    autoLogin()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.addNavigationBarCartButton()
    self.tabBarController?.delegate = self
  }
}

// MARK: - UI
extension SettingsViewController {
  private func autoLogin() {
    isLogin = UserDefaultManager.shared.isLogin()
  }
  
  private func setupUI() {
    view.addSubviews([myKurlyTableView])
    myKurlyTableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  @objc func didTapSingUpInButton() {
    let loginVC = UINavigationController(rootViewController: LoginViewController())
    loginVC.modalPresentationStyle = .fullScreen
    loginVC.navigationBar.tintColor = .black
    self.present(loginVC, animated: true, completion: nil)
  }
}

extension SettingsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    isLogin ? settingOptAfterLogin.count : settingOptBeforeLogin.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    isLogin ? settingOptAfterLogin[section].count : settingOptBeforeLogin[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      return isLogin
        ? tableView.dequeue(UserInfoTableViewCell.self).then {
            if let userName = UserDefaultManager.shared.get(for: .userName) {
              $0.configure(name: "\(userName)" )
            }
          }
        : tableView.dequeue(SettingsTableViewCell.self).then({
            $0.delegate = self
          })
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: "Detail", for: indexPath)
      let text = isLogin
        ? settingOptAfterLogin[indexPath.section][indexPath.row]
        : settingOptBeforeLogin[indexPath.section][indexPath.row]
      
      cell.textLabel?.text = text
      cell.accessoryType = .disclosureIndicator
      return cell
    }
  }
}
extension SettingsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    nil
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    0
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    nil
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    8
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if indexPath.section == 5 && indexPath.row == 0 {
      isLogin = false
      UserDefaultManager.shared.remove(for: .token)
      UserDefaultManager.shared.remove(for: .userName)
      self.addNavigationBarCartButton()
    }
  }
}

extension SettingsViewController: SettingsTableViewCellDelegate {
  func signInBonusButtonTouched(_ button: UIButton) {
    print("가입 혜택 버튼 클릭됨")
  }
  
  func logInButtonDidTouched(_ button: UIButton) {
    let nextVC = UINavigationController(rootViewController: LoginViewController())
    nextVC.modalPresentationStyle = .fullScreen
    self.present(nextVC, animated: true)
  }
}

extension SettingsViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    myKurlyTableView.setContentOffset(.zero, animated: true)
  }
}
