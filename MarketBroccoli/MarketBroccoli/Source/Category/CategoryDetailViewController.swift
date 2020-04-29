//
//  CategoryDetailViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/13.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

// MARK: - Protocol
protocol MenuBarCategoryTouchProtocol: class {
  func cellTouch(index: Int)
}

class CategoryDetailViewController: UIViewController {
  // MARK: - Properties
  private lazy var customMenuBar = CategoryDetailHeaderView().then {
    $0.customDelegate = self
  }
  private let customMenuBarSeperator = UIView().then {
    $0.backgroundColor = .darkGray
    $0.alpha = 0.4
  }
  let customMenuBarheigt: CGFloat = 50
  private lazy var collectionViewFlowLayout = UICollectionViewFlowLayout()
  private lazy var collectionView = UICollectionView(
    frame: .init(
      x: 0, y: customMenuBarheigt,
      width: view.frame.width,
      height: view.frame.height - customMenuBarheigt), // .zero로 했을 때 안나오는 문제 해결 할 것
    collectionViewLayout: collectionViewFlowLayout)
    .then {
      $0.isPagingEnabled = true
      $0.showsHorizontalScrollIndicator = false
      $0.register(cell: CategoryDetailCollectionViewCell.self)
      $0.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
  }
  var categoryDetailNavigationTitle = ""
  var selectedCellTitle = ""
  var categoryId: Int? {
    didSet {
      // categoryData[section].count
      print("didSet categoryID")
    }
  }
  var subCategoryId: Int? {
    didSet {
      //
      print("didSet subCategoryID")
    }
  }
  private let selectedCategory = CategorySelected()
  private var page: Int = 0 {
    didSet {
//      let width = self.collectionView
//        .cellForItem(at: IndexPath(item: 0, section: 0))?
//        .subviews
//        .compactMap { $0 as? UICollectionView }
//        .compactMap { $0.collectionViewLayout as? UICollectionViewFlowLayout }
//        .first?
//        .itemSize
//        .width
    }
  }
  private var collectionViewItems: CategoryProudcutList? {
    didSet {
      collectionView.reloadData()
    }
  }
  enum UI {
    static let inset: CGFloat = 14
    static let spacing: CGFloat = 14
  }
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupLayout()
    setupNavigtion()
    // 테이블뷰에서 누른 셀 만큼 컬렉션뷰와 커스텀메뉴바 움직이는 구간
    self.collectionView.isHidden = true
    self.customMenuBar.isHidden = true
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.addNavigationBarCartButton()
  }
  
  var itemWidth: CGFloat = 0
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.itemWidth = self.collectionView
      .visibleCells.first?
      .subviews
      .compactMap { $0 as? UICollectionView }
      .compactMap { $0.collectionViewLayout as? UICollectionViewFlowLayout }
      .first?
      .itemSize
      .width ?? 0
    print(itemWidth, "제발 나와줘")
    var subCategoryID = (subCategoryId ?? 0) - 1
    if subCategoryID == -1 {
      subCategoryID = 0
    }
    self.collectionView.scrollToItem(at: IndexPath(item: subCategoryID, section: 0), at: .right, animated: false)
    categoryMoved(subCategoryID, direction: false)
    self.collectionView.isHidden = false
    self.customMenuBar.isHidden = false
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews() // 타이밍이 컬렉션뷰 레이아웃이 잡히고
    // 그 다음에 플로우레이아웃이 잡혀야
    setupFlowLayout()
  }
  
  // MARK: - Setup Attribute
  private func setupUI() {
    view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
    collectionView.dataSource = self
    collectionView.delegate = self
    guard let categoryId = categoryId else { return }
    customMenuBar.categories(categories: categoryData[categoryId - 1].row)
    [collectionView, customMenuBar].forEach {
      view.addSubview($0)
    }
  }
  private func setupLayout() {
    let guide = view.safeAreaLayoutGuide
    collectionView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(guide.snp.bottom)
    }
    customMenuBar.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(guide)
      $0.height.equalTo(customMenuBarheigt)
    }
    [customMenuBarSeperator].forEach {
      view.addSubview($0)
    }
    customMenuBarSeperator.snp.makeConstraints {
      $0.top.equalTo(customMenuBar.snp.bottom)
      $0.leading.trailing.equalTo(guide)
      $0.bottom.equalTo(collectionView.snp.top)
      $0.height.equalTo(0.4)
    }
    [selectedCategory].forEach {
      customMenuBar.addSubview($0)
    }
    if let item = customMenuBar.subviews.first as? UILabel {
      item.textColor = .kurlyMainPurple
      item.font = .boldSystemFont(ofSize: 14)
      selectedCategory.snp.makeConstraints {
        $0.top.equalTo(item.snp.bottom).offset(-3)
        $0.leading.trailing.width.equalTo(item)
        $0.bottom.equalTo(customMenuBarSeperator.snp.top)
        $0.height.equalTo(3)
      }
    }
  }
  private func setupNavigtion() {
    self.setupSubNavigationBar(title: categoryDetailNavigationTitle)
  }
  private func setupFlowLayout() {
    let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    collectionViewFlowLayout.sectionInset = insets
    collectionViewFlowLayout.minimumLineSpacing = 0
    collectionViewFlowLayout.minimumInteritemSpacing = 0
    collectionViewFlowLayout.itemSize = CGSize(
      width: collectionView.frame.width,
      height: collectionView.frame.height
    )
    collectionViewFlowLayout.scrollDirection = .horizontal
  }
}
// MARK: - UICollectionViewDelegate
extension CategoryDetailViewController: UICollectionViewDelegate {
  func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    if scrollView == collectionView {
      let cellWidth = itemWidth * 2 + (UI.inset + UI.spacing * 2)
      var page = round(collectionView.contentOffset.x / cellWidth)
      var isRight = true
      if velocity.x > 0 {
        page += 1
        isRight = true
      }
      if velocity.x < 0 {
        page -= 1
        isRight = false
      }
      page = max(page, 0)
//      print(page, "페이지는!!!!!!!")
//      print(itemWidth, "아이템 사이즌!!!!!!!!!")
      targetContentOffset.pointee.x = page * cellWidth
      categoryMoved(Int(page), direction: isRight)
    }
  }
}

// MARK: - UICollectionViewDataSource
extension CategoryDetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let categoryId = categoryId else { return 0 }
      return categoryData[categoryId - 1].row.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let categoryId = categoryId else { return UICollectionViewCell() }
    let collectionViewSubCategoryId = (subCategoryId ?? 0) //+ indexPath.row
    switch indexPath.row {
    case 0:
      let cell = collectionView.dequeue(CategoryDetailCollectionViewCell.self, indexPath: indexPath)
      cell.configure(id: categoryId)
      print("몇번 째를 눌렀나 indexPath.row[0]", collectionViewSubCategoryId - 1)
      return cell
    default:
      let cell = collectionView.dequeue(CategoryDetailCollectionViewCell.self, indexPath: indexPath)
      let subCategoryIncerease = categoryData[0..<categoryId - 1].reduce(0) { $0 + $1.row.count } - categoryId + 1
      let subCategoryID = subCategoryIncerease + indexPath.row
      cell.subConfigure(subID: subCategoryID)
      return cell
    }
  }
}

// MARK: - ACTIONS
extension CategoryDetailViewController {
  private func categoryMoved(_ currentPage: Int, direction: Bool) {
    var subCategoryID = (subCategoryId ?? 0) - 1
    if subCategoryID == -1 {
      subCategoryID = 0
    }
    let categoryID = (categoryId ?? 0) - 1
    var menuBarTextWidth: CGFloat = 0
    let label = UILabel().then {
      $0.font = .systemFont(ofSize: 14)
    }
    for idx in 0..<currentPage { // getWidth() 카테고리 크기 구하는 함수
      label.text = categoryData[categoryID].row[idx]
//      print("여기에 집중", categoryData[categoryID].row[idx])
      menuBarTextWidth += (label.getWidth() ?? 0) // getWidth() 텍스트 크기 구하는 함수
    }
    let textWidth = (label.getWidth() ?? 0)
    let correction = (view.frame.width / 2) - textWidth + (textWidth / 2)
    print("menuBarTextWidt", menuBarTextWidth, "correction", correction)
    let movePoint = menuBarTextWidth - correction
    print("movePoint", movePoint)
    updateAnimation(movePoint: movePoint, page: currentPage, direction: direction)
  }
  
  private func updateAnimation(movePoint: CGFloat, page: Int, direction isRight: Bool) {
    // 움직일 다음 대상 카테고리 텍스트를 태그로 찾는 과정
    guard let item = customMenuBar.viewWithTag(9999 - page) as? UILabel else { return }
    customMenuBar.subviews.forEach {
      ($0 as? UILabel)?.textColor = .gray
      ($0 as? UILabel)?.font = .systemFont(ofSize: 14)
    }
    // 보라색 라인을 다음 아이템에 오토레이아웃 새로 잡을 예정인..
    selectedCategory.snp.remakeConstraints {
      $0.top.equalTo(item.snp.bottom).offset(-3)
      $0.leading.trailing.width.equalTo(item)
      $0.height.equalTo(3)
    }
    UIView.animate(withDuration: 0.5, animations: {
      item.textColor = .kurlyMainPurple
      item.font = .boldSystemFont(ofSize: 14)
      if 2...5 ~= page { // 중간 카테고리
        self.customMenuBar.setContentOffset(CGPoint(x: movePoint, y: 0), animated: false)
      } else if 0...1 ~= page { // 카테고리 first를 확인해서 움직이지 않게
        self.customMenuBar.setContentOffset(CGPoint(x: -16, y: 0), animated: false)
      } else { // 카테고리 last를 확인해서 움직이지 않게 그래서 max
        self.customMenuBar.setContentOffset(CGPoint(x: self.customMenuBar.maxContentOffset.x, y: 0), animated: false)
      }
      self.customMenuBar.layoutIfNeeded()// 레이아웃을 바로 그리도록 호출하는 기능
      // 메인 쓰레드 즉시 호출
    })
  }
  
  private func productMoved(_ currentPage: Int) {
    let movePoint = CGPoint(x: (self.itemWidth * 2 + (UI.inset + UI.spacing * 2)) * CGFloat(currentPage), y: 0)
    self.collectionView.setContentOffset(movePoint, animated: true)
  }
}

extension CategoryDetailViewController: MenuBarCategoryTouchProtocol {
  func cellTouch(index: Int) {
    productMoved(index)
    categoryMoved(index, direction: false)
  }
}
