//
//  RecommendationCollectionViewCell.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/07.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class RecommendationCollectionViewCell: UICollectionViewCell {
  // MARK: - Properties
  private let imageView = UIImageView().then {
    $0.backgroundColor = .systemTeal
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
  }
  private let titleLabel = UILabel().then {
//    $0.textColor = .kurlyGray1
    $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
  }
  private let frameView = UIView().then {
    $0.layer.borderColor = UIColor.darkGray.cgColor
    $0.layer.borderWidth = 1.0
    $0.alpha = 0.1
  }
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  override func layoutSubviews() {
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func setupUI() {
    [imageView, titleLabel, frameView].forEach {
      self.addSubview($0)
    }
  }
  private func setupLayout() {
    imageView.snp.makeConstraints { (make) -> Void in
      make.leading.top.trailing.equalToSuperview()
      make.width.equalToSuperview()
      make.bottom.equalTo(titleLabel.snp.top)
    }
    titleLabel.snp.makeConstraints { (make) -> Void in
      make.leading.equalToSuperview().offset(10)
      make.trailing.bottom.equalToSuperview()
      make.top.equalTo(imageView.snp.bottom)
      make.height.equalTo(40)
    }
    frameView.snp.makeConstraints { (make) -> Void in
      make.edges.equalToSuperview()
    }
  }
  func configure(image: UIImage?, title: String) {
    imageView.image = image
    titleLabel.text = title
  }
}
