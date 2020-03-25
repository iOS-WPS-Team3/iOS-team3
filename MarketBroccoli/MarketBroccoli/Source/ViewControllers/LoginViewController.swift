//
//  LoginViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    private var idTextField = UITextField()
    private var pwTextField = UITextField()
    private var logInbtn = UIButton()
    private var idFindBtn = UIButton()
    private var pwFindBtn = UIButton()
    private var signUpBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUI()
    }
    
    private func setNavigation() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.title = "로그인"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "xmark"), style: .done, target: self, action: #selector(didTapCancelButton))
    }
    
    private func setUI() {
        view.backgroundColor = .white
        idTextField.textFeildStyle(placeholder: "아이디를 입력해주세요")
        pwTextField.textFeildStyle(placeholder: "비밀번호를 입력해주세요")
        pwTextField.isSecureTextEntry = true
        logInbtn.roundPurpleBtnStyle(title: "로그인") // addTarget 필요
        idFindBtn = self.tinyGrayBtn(title: "아이디 찾기 |")
        pwFindBtn = self.tinyGrayBtn(title: "비밀번호 찾기")
        signUpBtn.roundLineBtnStyle(title: "회원가입") // addTarget 필요
        [idTextField, pwTextField, logInbtn, idFindBtn, pwFindBtn, signUpBtn].forEach {
          view.addSubview($0)
        }
        setLayout()
    }
    
    private func setLayout() {
        let guide = view.safeAreaLayoutGuide
        let margin: CGFloat = 32
        let height: CGFloat = 14
        let btnBetweenMargin: CGFloat = 40
        let btnTopMargin: CGFloat = 12

        idTextField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(guide.snp.height).dividedBy(height)
            make.top.equalTo(guide.snp.top).offset(margin)
            make.left.equalTo(guide.snp.left).offset(margin)
            make.right.equalTo(guide.snp.right).offset(-margin)
        }
        pwTextField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(guide.snp.height).dividedBy(height)
            make.top.equalTo(idTextField.snp.bottom).offset(btnTopMargin)
            make.left.equalTo(guide.snp.left).offset(margin)
            make.right.equalTo(guide.snp.right).offset(-margin)
        }
        logInbtn.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(guide.snp.height).dividedBy(height)
            make.top.equalTo(pwTextField.snp.bottom).offset(24)
            make.left.equalTo(guide.snp.left).offset(margin)
            make.right.equalTo(guide.snp.right).offset(-margin)
        }
        idFindBtn.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(guide.snp.centerX).offset(-btnBetweenMargin)
            make.top.equalTo(logInbtn.snp.bottom).offset(btnTopMargin)
        }
        pwFindBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(idFindBtn.snp.right).offset(4)
            make.top.equalTo(logInbtn.snp.bottom).offset(btnTopMargin)
        }
        signUpBtn.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(guide.snp.height).dividedBy(height)
            make.top.equalTo(idFindBtn.snp.bottom).offset(btnBetweenMargin)
            make.left.equalTo(guide.snp.left).offset(margin)
            make.right.equalTo(guide.snp.right).offset(-margin)
        }
    }
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didtapFindButton(_ sender: UIButton) {
        switch sender.title(for: .normal) {
        case "아이디 찾기 |":
            navigationController?.pushViewController(IDFindViewController(), animated: true)
        case "비밀번호 찾기":
            navigationController?.pushViewController(PWFindViewController(), animated: true)
        default:
           self.dismiss(animated: true, completion: nil)

        }
    }
    
    private func tinyGrayBtn(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(didtapFindButton(_:)), for: .touchUpInside)
        return button
    }
    
}
