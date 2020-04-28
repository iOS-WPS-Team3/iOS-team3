//
//  SearchViewController.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/27.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class SearchViewController: UIViewController {
  // MARK: - Properties
  
  private var isShowingPopularSearchWords = true
  
  private let popularSearchWords = ["사골곰탕", "마스크팩", "베트남 용과", "로트벡쉔", "한돈 등심", "자몽", "손질새우"]
  
  private var recentSearchWords = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] {
    didSet {
      if recentSearchWords.count > 10 { recentSearchWords.removeLast() }
    }
  }
  
  private var searchedProducts: SearchedProducts? {
    didSet {
      searchView.reloadSearchResultCollectionViewData()
    }
  }
  
  private lazy var searchView = SearchView().then {
    $0.dataSource = self
    $0.delegate = self
  }
  
  // MARK: - Life Cycle
  
  override func loadView() {
    view = searchView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupBroccoliNavigationBar(title: "검색")
    searchWordTableViewWillFollowKeyboard()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.addNavigationBarCartButton()
    self.tabBarController?.delegate = self
  }
}

// MARK: - Data Source

extension SearchViewController: SearchViewDataSource {
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    isShowingPopularSearchWords ? "인기검색어" : "최근 검색어"
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    isShowingPopularSearchWords ? popularSearchWords.count : recentSearchWords.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let text = isShowingPopularSearchWords ? popularSearchWords[indexPath.row] : recentSearchWords[indexPath.row]
    let cell = isShowingPopularSearchWords
      ? tableView.dequeue(PopularSearchWordCell.self)
      : tableView.dequeue(RecentSearchWordCell.self)
    
    cell.do {
      $0.textLabel?.text = text
    }
    
    return cell
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath
  ) -> UICollectionReusableView {
    collectionView.dequeue(ProductCollectionHeader.self, indexPath: indexPath).then {
      $0.configure(
        hideOrderTypeButton: false,
        deliveryAreas: ["샛별지역상품", "택배지역상품"],
        orderTypes: ["신상품순", "인기상품", "낮은 가격순", "높은 가격순"]
      )
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let searchedProducts = searchedProducts else { return 0 }
    
    return searchedProducts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(ProductCollectionCell.self, indexPath: indexPath)
    guard let searchedProducts = searchedProducts else { return cell }
    let product = searchedProducts[indexPath.row]
    
    cell.do {
      $0.delegate = self
      $0.configure(
        productId: product.id,
        productName: product.name,
        productImage: product.imageURL,
        price: product.price,
        discount: product.discountRate,
        additionalInfo: ["Kurly Only"],
        isSoldOut: false,
        productIndexPath: indexPath
      )
    }
    
    return cell
  }
}

// MARK: - Action Handler

extension SearchViewController: SearchViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let searchWord = isShowingPopularSearchWords ? popularSearchWords[indexPath.row] : recentSearchWords[indexPath.row]
    
    fetchSearchResult(searchWord: searchWord) { [weak self] result in
      switch result {
      case .success(let data):
        guard
          let self = self,
          let searchResult = try? JSONDecoder().decode(SearchedProducts.self, from: data)
        else { return }
        
        self.searchedProducts = searchResult
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
    
    searchView.setSearchProductTextField(text: searchWord)
    searchView.resignSearchProductTextFieldFirstResponder()
    searchView.hideSearchResultCollectionView(false)
    searchView.hideSearchWordTableView(true)
    searchView.activateCancelSearchButton(true)
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let navigationController = navigationController, let searchedProducts = searchedProducts else { return }
    let productDetailViewController = DetailViewController().then {
      $0.configure(productId: searchedProducts[indexPath.row].id)
      $0.hidesBottomBarWhenPushed = true
    }
    
    navigationController.pushViewController(productDetailViewController, animated: true)
  }
  
  func searchProductTextFieldEditingDidBegin(_ textField: UITextField, _ button: UIButton) {
    button.isEnabled = true
    
    isShowingPopularSearchWords = false
    searchView.reloadSearchWordTableViewData()
  }
  
  func searchProductTextFieldEditingChanged(_ textField: UITextField, _ text: String) {
    print("searchProductTextFieldEditingChanged")
  }
  
  func searchProductTextFieldSearchButtonTouched(_ textField: UITextField, _ text: String) {
    textField.resignFirstResponder()
    recentSearchWords.insert(text, at: 0)
    searchView.reloadSearchWordTableViewData()
    searchView.hideSearchWordTableView(true)
    searchView.hideSearchResultCollectionView(false)
  }
  
  func cancelSearchButtonTouched(_ button: UIButton, _ textField: UITextField) {
    textField.text = ""
    button.isEnabled = false
    textField.resignFirstResponder()
    
    isShowingPopularSearchWords = true
    searchView.reloadSearchWordTableViewData()
    searchView.hideSearchWordTableView(false)
    searchView.hideSearchResultCollectionView(true)
  }
  
  func searchingRefreshControlValueChanged(_ refreshControl: UIRefreshControl, _ tableView: UITableView) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      tableView.reloadData()
      refreshControl.endRefreshing()
    }
  }
  
  private func searchWordTableViewWillFollowKeyboard() {
    _ = NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardDidShowNotification,
      object: nil,
      queue: OperationQueue.main) { (noti) in
        if let frameValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
          let keyboardFrame = frameValue.cgRectValue
          
          self.searchView.updateSearchWordTableViewBottomConstraint(keyboardFrame.size.height)
          self.view.layoutIfNeeded()
        }
    }
    
    _ = NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardWillHideNotification,
      object: nil,
      queue: OperationQueue.main) { _ in
        self.searchView.updateSearchWordTableViewBottomConstraint(0)
        self.view.layoutIfNeeded()
    }
  }
}

extension SearchViewController: ProductCollectionCellDelegate {
  func cartOrAlarmButtonTouched(_ collectionView: UICollectionView, _ button: UIButton, _ productIndexPath: IndexPath) {
    guard let searchedProducts = searchedProducts else { return }
    let isSoldOut = false
    
    if !isSoldOut {
      let navigationController = UINavigationController(rootViewController: AddProductCartViewController())
      
      present(navigationController, animated: true) {
        navigationController.do {
          guard let firstViewController = $0.viewControllers.first as? AddProductCartViewController else { return }
          
          firstViewController.deliver(
            id: searchedProducts[productIndexPath.row].id,
            name: searchedProducts[productIndexPath.row].name,
            price: searchedProducts[productIndexPath.row].price,
            discountRate: searchedProducts[productIndexPath.row].discountRate
          )
        }
      }
    }
  }
}

extension SearchViewController {
  private func fetchSearchResult(searchWord: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
    AF.request(
      "http://15.164.49.32/kurly/best/",
      method: .get
    )
      .validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          completionHandler(.success(data))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
}

extension SearchViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    searchView.setSearchResultCollectionViewContentOffset(.zero)
  }
}
