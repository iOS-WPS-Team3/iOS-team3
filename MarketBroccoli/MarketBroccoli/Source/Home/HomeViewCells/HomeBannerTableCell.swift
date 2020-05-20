//
//  HomeBannerTableCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Then
import SnapKit

class HomeBannerTableCell: UITableViewCell {
  private lazy var bannerCountLabel = UILabel().then {
    $0.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 12)
    $0.layer.cornerRadius = 8
    $0.layer.masksToBounds = true
  }
  private let bannerCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: CustomCollectionViewFlowLayout()
  ).then {
    $0.isPagingEnabled = true
    $0.bounces = false
    $0.showsHorizontalScrollIndicator = false
  }
  
  private var dummyData: [String]? {
    didSet {
      bannerCountLabel.text = " \(currentPage) / \(dummyData?.count ?? 0) "
    }
  }
  private var currentPage = 1
  private var scrollingTimer = Timer()
  private var imageCounter = 0
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
    DispatchQueue.main.async {
      self.scrollingTimer = Timer.scheduledTimer(
        timeInterval: 3.0,
        target: self,
        selector: #selector(self.startTimer(_:)),
        userInfo: nil, repeats: true)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeBannerTableCell {
  func configure(items: [String]) {
    dummyData = items
  }
}

// MARK: - ACTIONS
extension HomeBannerTableCell {
  @objc private func startTimer(_ timer: Timer) {
    guard let bannerCnt = dummyData?.count else { return }
    if imageCounter < bannerCnt {
      let index = IndexPath(item: imageCounter, section: 0)
      self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
      imageCounter += 1
    } else {
      imageCounter = 0
      let index = IndexPath(item: imageCounter, section: 0)
      self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
    }
  }
}

// MARK: - UI
extension HomeBannerTableCell {
  private func setupLayout() {
    guard let layout = bannerCollectionView.collectionViewLayout as? CustomCollectionViewFlowLayout else { return }
    layout.minimumLineSpacing = 0
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.itemSize = CGSize(width: self.frame.width, height: 350)
  }
  
  private func setupAttr() {
    bannerCollectionView.delegate = self
    bannerCollectionView.dataSource = self
    bannerCollectionView.register(cell: BannerCollectionCell.self)
  }
  
  private func setupUI() {
    self.contentView.addSubview(bannerCollectionView)
    self.contentView.addSubview(bannerCountLabel)
    
    bannerCollectionView.snp.makeConstraints {
      $0.top.leading.bottom.trailing.equalTo(self.contentView)
      $0.height.equalTo(350)
    }
    
    bannerCountLabel.snp.makeConstraints {
      $0.bottom.trailing.equalTo(bannerCollectionView).inset(20)
    }
    
    setupAttr()
  }
}

// MARK: - CollectionView DataSource
extension HomeBannerTableCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dummyData?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let model = dummyData else { return UICollectionViewCell() }
    let cell = collectionView.dequeue(BannerCollectionCell.self, indexPath: indexPath)
    cell.configure(image: model[indexPath.item])
    let numberOfRecord: Int = model.count - 1
    var row = indexPath.row
    if row < numberOfRecord {
      row += 1
    } else {
      row = 0
    }
    return cell
  }
}

// MARK: - CollectionView Delegate
extension HomeBannerTableCell: UICollectionViewDelegate {
  func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>
  ) {
    guard let bannerCnt = dummyData?.count else { return }
    imageCounter = imageCounter < bannerCnt ? imageCounter + 1 : 0
  }
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let bannerWidth = bannerCollectionView.frame.size.width
    currentPage = Int(bannerCollectionView.contentOffset.x / bannerWidth) + 1
    DispatchQueue.main.async {
      self.bannerCountLabel.text = " \(self.currentPage) / \(self.dummyData?.count ?? 0) "
    }
  }
}
