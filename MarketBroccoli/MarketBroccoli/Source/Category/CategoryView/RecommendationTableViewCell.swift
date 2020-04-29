//
//  RecommendationTableViewCell.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/07.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {
  // MARK: - Properties
  static let identifier: String = "recommendationTableViewCell"
  private lazy var collectionViewFlowLayout = UICollectionViewFlowLayout()
  private let recommendationTitles = [
    "식단관리", "전자레인지 간편식", "3천원의 행복", "간편한 아침식사", "제철 음식", "오프라인 맛집", "컬리가 만든 상품", "키토제닉"
  ]
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: collectionViewFlowLayout)
    .then {
      $0.backgroundColor = .white
      $0.register(cell: UICollectionViewCell.self, forCellReuseIdentifier: "cell")
      $0.register(cell: RecommendationCollectionViewCell.self)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupFlowLayout()
  }
  
  private func setupUI() {
    collectionView.dataSource = self
    collectionView.delegate = self
    [collectionView].forEach {
      contentView.addSubview($0)
    }
    
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.height.equalTo(700)
    }
  }
  
  private func setupFlowLayout() {
    let minimumLineSpacing: CGFloat = 10.0
    let minimumInteritemSpacing: CGFloat = 10.0
    let insets = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    let itemsForLine: CGFloat = 2
    let itemSizeWidth = (
      (
        self.frame.width - (
          insets.left + insets.right + minimumInteritemSpacing * (itemsForLine - 1))
        ) / itemsForLine
      ).rounded(.down)
    let itemSize = CGSize(width: itemSizeWidth, height: itemSizeWidth - 8)
    collectionViewFlowLayout.sectionInset = insets
    collectionViewFlowLayout.minimumLineSpacing = minimumLineSpacing
    collectionViewFlowLayout.minimumInteritemSpacing = minimumInteritemSpacing
    collectionViewFlowLayout.itemSize = itemSize
    collectionViewFlowLayout.scrollDirection = .vertical
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UICollectionViewDataSource
extension RecommendationTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return recommendationTitles.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(RecommendationCollectionViewCell.self, indexPath: indexPath)
      cell.configure(
      image: UIImage(named: recommendationTitles[indexPath.row]),
      title: recommendationTitles[indexPath.row]
    )
    return cell
  }
}
// MARK: - UICollectionViewDelegate
extension RecommendationTableViewCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let alertController = UIAlertController(
      title: "준비 중",
      message: "이 기능은 현재 준비 중인 기능입니다.\n조금만 기다려주세요!",
      preferredStyle: .alert)
    let defaultAction = UIAlertAction(
      title: "나중에 만나요",
      style: .destructive,
      handler: nil
    )
    alertController.addAction(defaultAction)
    if let rootVC = self.window?.rootViewController {
      rootVC.present(alertController, animated: true)
    }
  }
}
