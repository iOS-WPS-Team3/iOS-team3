//
//  DetailRootView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/03.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class DetailRootView: UIView {
  private let selectedCategory = CategorySelected()
  private let stackView = CategoryStackView(categories: Categories.DetailCategory, distribution: .fillProportionally)
  private lazy var purchaseBtn = UIButton(type: .system).then {
    $0.setTitle("구매하기", for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
    $0.contentEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .kurlyMainPurple
    $0.contentVerticalAlignment = .top
    $0.addTarget(self, action: #selector(purchaseBtnTouched(_:)), for: .touchUpInside)
  }
  let scrollView = UIScrollView().then {
    $0.isPagingEnabled = true
    $0.showsHorizontalScrollIndicator = false
    $0.bounces = false
  }
  let detailImageView = DetailImageView()
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupAttr()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Deleagate
extension DetailRootView: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let screenWidth = self.scrollView.frame.size.width
    let currentOffsetX = scrollView.contentOffset.x
    guard screenWidth > 0 && currentOffsetX > 0 else { return }
    let currentPage = Int((currentOffsetX + (screenWidth / 2)) / screenWidth)
    scrollMoved(currentPage)
  }
}

// MARK: - ACTIONS
extension DetailRootView {
  private func scrollMoved(_ currentPage: Int, scroll: Bool = false) {
    guard let label = stackView.arrangedSubviews[currentPage] as? UILabel else { return }
    stackView.arrangedSubviews.forEach {
      ($0 as? UILabel)?.textColor = .gray
    }
    
    selectedCategory.snp.remakeConstraints {
      $0.bottom.equalTo(label.snp.bottom)
      $0.centerX.equalTo(label.snp.centerX)
      $0.width.equalTo(label.getWidth() ?? 0)
      $0.height.equalTo(5)
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
  
  @objc private func purchaseBtnTouched(_ button: UIButton) {
    ObserverManager.shared.post(observerName: .purchaseBtnTouched, object: nil)
  }
}

// MARK: - UI
extension DetailRootView {
  private func setupAttr() {
    self.backgroundColor = .white
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
    let safeArea = self.safeAreaLayoutGuide
    guard let firstStackViewItem = stackView.arrangedSubviews.first as? UILabel else { return }
    firstStackViewItem.textColor = .kurlyMainPurple
    self.addSubviews([stackView, scrollView, purchaseBtn])
    self.stackView.addSubview(selectedCategory)
    stackView.snp.makeConstraints {
      $0.top.equalTo(safeArea.snp.top)
      $0.leading.trailing.equalTo(safeArea)
    }
    
    selectedCategory.snp.makeConstraints {
      $0.bottom.equalTo(firstStackViewItem.snp.bottom)
      $0.centerX.equalTo(firstStackViewItem.snp.centerX)
      $0.width.equalTo(firstStackViewItem.getWidth() ?? 0)
      $0.height.equalTo(4)
    }
    
    scrollView.snp.makeConstraints {
      $0.top.equalTo(stackView.snp.bottom)
      $0.leading.trailing.equalTo(safeArea)
    }
    purchaseBtn.snp.makeConstraints {
      $0.top.equalTo(scrollView.snp.bottom)
      $0.leading.trailing.equalTo(safeArea)
      $0.bottom.equalToSuperview()
      $0.height.equalTo(self).dividedBy(8)
    }
    
    var categoryArray: [UIView] = []
    let categoryCnt = Categories.DetailCategory.count
    for idx in Categories.DetailCategory.indices {
      switch idx {
      case 0:
        categoryArray.append(DetailDescriptionTableView())
      case 1:
        categoryArray.append(detailImageView)
      case 2...categoryCnt - 1:
        categoryArray.append(DetailCautionView())
      default:
        fatalError()
      }
    }
    makeCategoryConstraint(target: scrollView, categories: categoryArray)
  }
}
