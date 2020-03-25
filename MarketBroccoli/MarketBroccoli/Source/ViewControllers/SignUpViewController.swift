//
//  SignUpViewController.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let signupTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setupUI()
    }
  private func setupUI() {
    [signupTableView].forEach {
      view.addSubview($0)
    }
    
    signupTableView.rowHeight = 120
    
    signupTableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
     
    signupTableView.dataSource = self
    signupTableView.register(SignupTableViewCell.self, forCellReuseIdentifier: SignupTableViewCell.identifier)
  }
}

extension SignUpViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard indexPath.row == 0 else { return UITableViewCell() }
    let cell = tableView.dequeueReusableCell(withIdentifier: SignupTableViewCell.identifier, for: indexPath) as! SignupTableViewCell
    return cell
  }
}
