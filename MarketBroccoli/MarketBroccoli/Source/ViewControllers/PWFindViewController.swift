//
//  PWFindViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class PWFindViewController: UIViewController {
    
    private var nameTextField = UITextField()
    private var idTextField = UITextField()
    private var emailTextField = UITextField()
    private var submitButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUI()
        setLayout()
    }
    private func setNavigation() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.title = "비밀번호 찾기"
    }
    private func setUI() {
        view.backgroundColor = .white
        nameTextField.textFeildStyle(placeholder: "이름을 입력해주세요")
        idTextField.textFeildStyle(placeholder: "아이디를 입력해주세요")
        emailTextField.textFeildStyle(placeholder: "가입한 이메일을 입력해주세요")
        emailTextField.keyboardType = .emailAddress
        submitButton.roundPurpleBtnStyle(title: "확인") //addtarget 필요
        [nameTextField, idTextField, emailTextField, submitButton].forEach {
                   view.addSubview($0) }
    }
    private func setLayout() {
        let guide = view.safeAreaLayoutGuide
        let margin: CGFloat = 32
        let height: CGFloat = 14
        let btnTopMargin: CGFloat = 12
        nameTextField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(guide.snp.height).dividedBy(height)
            make.top.equalTo(guide.snp.top).offset(margin)
            make.left.equalTo(guide.snp.left).offset(margin)
            make.right.equalTo(guide.snp.right).offset(-margin)
        }
        idTextField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(guide.snp.height).dividedBy(height)
            make.top.equalTo(nameTextField.snp.bottom).offset(btnTopMargin)
            make.left.equalTo(guide.snp.left).offset(margin)
            make.right.equalTo(guide.snp.right).offset(-margin)
        }
        emailTextField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(guide.snp.height).dividedBy(height)
            make.top.equalTo(idTextField.snp.bottom).offset(btnTopMargin)
            make.left.equalTo(guide.snp.left).offset(margin)
            make.right.equalTo(guide.snp.right).offset(-margin)
        }
        submitButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(guide.snp.height).dividedBy(height)
            make.top.equalTo(emailTextField.snp.bottom).offset(margin)
            make.left.equalTo(guide.snp.left).offset(margin)
            make.right.equalTo(guide.snp.right).offset(-margin)
        }
    }
    
    @objc private func didTapSubmitButton() {
        
    }
}

