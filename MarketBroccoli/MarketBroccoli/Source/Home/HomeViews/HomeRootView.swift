//
//  HomeRootView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Kingfisher

class HomeRootView: UIView {
  private let selectedCategory = CategorySelected()
  private let scrollView = UIScrollView().then {
    $0.backgroundColor = .gray
    $0.isPagingEnabled = true
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.bounces = false
  }
  
  private let stackView = CategoryStackView(categories: Categories.HomeCategory, distribution: .fillProportionally)
  
  private let menuTextArray = Categories.HomeCategory
  private var newModel: [MainItem] = []
  private var bestModel: [MainItem] = []
  private var discountModel: [MainItem] = []
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ACTIONS
extension HomeRootView {
  private func scrollMoved(_ currentPage: Int, scroll: Bool = false) {
    guard let label = stackView.arrangedSubviews[currentPage] as? UILabel else { return }
    stackView.arrangedSubviews.forEach {
      ($0 as? UILabel)?.textColor = .gray
    }
    
    selectedCategory.snp.remakeConstraints {
      $0.bottom.equalTo(label.snp.bottom)
      $0.centerX.equalTo(label.snp.centerX)
      $0.width.equalTo(label.getWidth() ?? 0)
      $0.height.equalTo(4)
    }
    
    UIView.animate(withDuration: 0.3) {
      label.textColor = .kurlyMainPurple
      if scroll {
        let movePoint = CGPoint(x: self.frame.size.width * CGFloat(currentPage), y: 0)
        self.scrollView.setContentOffset(movePoint, animated: false)
      }
      self.layoutIfNeeded()
    }
  }
  
  @objc private func categoryTouched(_ sender: UITapGestureRecognizer) {
    guard let label = sender.view as? UILabel,
      let labelIdx = stackView.arrangedSubviews.firstIndex(of: label)
      else { return }
    scrollMoved(labelIdx, scroll: true)
  }
}

// MARK: - UI
extension HomeRootView {
  private func setupAttr() {
    scrollView.delegate = self
    categoryAddGesture()
  }
  
  private func categoryAddGesture() {
    stackView.subviews.forEach {
      guard let label = $0 as? UILabel else { return }
      let tap = UITapGestureRecognizer(target: self, action: #selector(categoryTouched(_:)))
      label.addGestureRecognizer(tap)
    }
  }
  
  private func setupUI() {
    setupAttr()
    let safeArea = self.safeAreaLayoutGuide
    guard let firstStackViewItem = stackView.arrangedSubviews.first as? UILabel else { return }
    firstStackViewItem.textColor = .kurlyMainPurple
    self.addSubviews([scrollView, stackView])
    stackView.addSubview(selectedCategory)
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(safeArea.snp.top)
      $0.leading.trailing.equalTo(self)
    }
    
    selectedCategory.snp.makeConstraints {
      $0.bottom.equalTo(firstStackViewItem.snp.bottom)
      $0.centerX.equalTo(firstStackViewItem.snp.centerX)
      $0.width.equalTo(firstStackViewItem.getWidth() ?? 0)
      $0.height.equalTo(5)
    }
    
    scrollView.snp.makeConstraints {
      $0.top.equalTo(stackView.snp.bottom)
      $0.leading.bottom.trailing.equalTo(safeArea)
    }
    
    var categoryArray: [UIView] = []
    let categoryCnt = menuTextArray.count
    for idx in menuTextArray.indices {
      switch idx {
      case 0:
        categoryArray.append(RecommendationView())
      case 1...categoryCnt - 2:
        let product = NewProduct(frame: .zero, collectionViewLayout: CustomCollectionViewFlowLayout())
        product.dataSource = self
        product.delegate = self
        product.register(cell: ProductCollectionCell.self)
        product.collectionName = ""
        categoryArray.append(product)
      case categoryCnt - 1:
        categoryArray.append(RecommendationView())
      default:
        fatalError("out of range")
      }
    }
    makeCategoryConstraint(target: scrollView, categories: categoryArray)
  }
}

// MARK: - ScrollViewDelegate
extension HomeRootView: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let screenWidth = self.scrollView.frame.size.width
    let currentOffsetX = scrollView.contentOffset.x
    guard screenWidth > 0 && currentOffsetX > 0 else { return }
    let currentPage = Int((currentOffsetX + (screenWidth / 2)) / screenWidth)
    scrollMoved(currentPage)
  }
}

extension HomeRootView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat { 8 }
  
  // 최소 아이템 간격
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { 8 }
  
  // 컬렉션 뷰 인셋
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  }
  
  // 아이템 사이즈
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemWidth = ((self.frame.width - (8 * 2) - (8 * (2 - 1))) / 2).rounded(.down)
    return CGSize(width: itemWidth, height: itemWidth * 1.8)
  }
}
// MARK: - CollectionViewDataSource
extension HomeRootView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    productDummy.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let product = productDummy[indexPath.row]
    switch collectionView {
    case is NewProduct:
      let cell = collectionView.dequeue(ProductCollectionCell.self, indexPath: indexPath)
      cell.configure(
        productName: product.name,
        productImage: ImageResource(downloadURL: product.imageURL),
        price: product.price,
        discount: product.discount,
        additionalInfo: product.additionalInfo,
        isSoldOut: product.isSoldOut,
        productIndexPath: indexPath
      )
      return cell
    default:
      return collectionView.dequeue(HomeReuseCollectionCell.self, indexPath: indexPath)
    }
  }
}
