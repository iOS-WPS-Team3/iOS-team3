//
//  DetailDescriptionBottomTableCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/07.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Kingfisher

class DetailDescriptionBottomTableCell: UITableViewCell {
  private let deliveryNotice = DeliveryNoticeView()
  let descriptionImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  private let summaryLabel = UILabel().then {
    $0.text = ""
    $0.font = .systemFont(ofSize: 28, weight: .semibold)
    $0.textColor = .darkGray
    $0.textAlignment = .center
    $0.adjustsFontSizeToFitWidth = true
    $0.minimumScaleFactor = 0.6
    $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    $0.numberOfLines = 2
  }
  private let nameLabel = UILabel().then {
    $0.text = ""
    $0.font = .systemFont(ofSize: 28, weight: .semibold)
    $0.textColor = .darkGray
    $0.numberOfLines = 0
    $0.textAlignment = .center
  }
  private let seperator = Seperator()
  private let descriptionLabel = UILabel().then {
    $0.text = ""
    $0.numberOfLines = 0
    $0.font = .systemFont(ofSize: 16, weight: .thin)
    $0.textColor = .darkGray
  }
  
  private let checkPointImageView = UIImageView().then {
    $0.contentMode = . scaleAspectFit
  }
  
  private lazy var detailImageView = UIImageView().then {
    let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTouched(_:)))
    
    $0.contentMode = .scaleAspectFit
    $0.isUserInteractionEnabled = true
    $0.addGestureRecognizer(imageTap)
  }
  private let whyKurly = WhyKurlyView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ACTIONS
extension DetailDescriptionBottomTableCell {
  func configure(detail model: ProductModel, images: [String: UIImage]) {
    summaryLabel.text = model.summary
    nameLabel.text = model.name
    descriptionLabel.text = model.productModelDescription
    descriptionLabel.lineSpacing(4)
    descriptionImageView.image = images["thumb"]
    detailImageView.image = images["detail"]
    checkPointImageView.image = images["check"]
    if let size = checkPointImageView.image?.size {
      let ratio = UIScreen.main.bounds.width / size.width
      let height = size.height * ratio
      checkPointImageView.snp.updateConstraints {
        $0.height.equalTo(height)
      }
    }
    
    if let size = self.detailImageView.image?.size {
      let ratio = UIScreen.main.bounds.width / size.width
      let height = size.height * ratio
      detailImageView.snp.updateConstraints {
        $0.height.equalTo(height)
      }
      detailImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 999), for: .vertical)
    }
  }
  
  @objc private func imageTouched(_ sender: UITapGestureRecognizer) {
    ObserverManager.shared.post(
      observerName: .imageTouched,
      object: nil,
      userInfo: ["image": detailImageView.image ?? UIImage()]
    )
  }
}

extension DetailDescriptionBottomTableCell {
  private func setupUI() {
    self.contentView.addSubviews(
      [
        deliveryNotice, descriptionImageView, summaryLabel, nameLabel,
        seperator, descriptionLabel, checkPointImageView, detailImageView, whyKurly
    ])
    deliveryNotice.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(180)
    }
    descriptionImageView.snp.makeConstraints {
      $0.top.equalTo(deliveryNotice.snp.bottom).offset(40)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
      $0.height.equalTo(300)
    }
    
    summaryLabel.snp.makeConstraints {
      $0.top.equalTo(descriptionImageView.snp.bottom).offset(40)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
      $0.height.equalTo(40)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(summaryLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
      $0.height.equalTo(40)
    }
    
    summaryLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 999), for: .vertical)
    nameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 999), for: .vertical)
    
    seperator.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
      $0.height.equalTo(1)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(seperator.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    checkPointImageView.snp.makeConstraints {
      $0.top.equalTo(descriptionLabel.snp.bottom)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
      $0.height.equalTo(0)
    }
    
    detailImageView.snp.makeConstraints {
      $0.top.equalTo(checkPointImageView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.width.equalToSuperview()
      $0.height.equalTo(0)
    }
    detailImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 999), for: .vertical)
    
    whyKurly.snp.makeConstraints {
      $0.top.equalTo(detailImageView.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20))
      $0.height.equalTo(600)
    }
  }
}
