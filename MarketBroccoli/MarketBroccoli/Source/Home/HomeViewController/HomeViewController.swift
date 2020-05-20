//
//  HomeViewController.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  let rootView = HomeRootView()
  
  override func loadView() {
    view = rootView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarController?.delegate = self
    self.setupBroccoliNavigationBar(title: "마켓브로콜리")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    ObserverManager.shared.registerObserver(
      target: self, selector: #selector(receiveNotification(_:)), observerName: .productTouched, object: nil)
    ObserverManager.shared.registerObserver(
      target: self, selector: #selector(receiveNotificationShowAll(_:)), observerName: .showAllBtnTouched, object: nil)
    ObserverManager.shared.registerObserver(
      target: self, selector: #selector(cartOrAlarmBtnTouched(_:)),
      observerName: .cartOrAlarmBtnTouched, object: nil)
    
    self.addNavigationBarCartButton()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    ObserverManager.shared.resignObserver(
      target: self,
      observerName: .productTouched,
      object: nil)
    ObserverManager.shared.resignObserver(
      target: self,
      observerName: .showAllBtnTouched,
      object: nil)
    ObserverManager.shared.resignObserver(
      target: self,
      observerName: .cartOrAlarmBtnTouched,
      object: nil)
  }
}

// MARK: - ACTIONS
extension HomeViewController {
  @objc private func receiveNotification(_ notification: Notification) {
    guard let userInfo = notification.userInfo as? [String: Int],
      let ID = userInfo["productId"] else { return }
    
    let detailVC = DetailViewController()
    detailVC.configure(productId: ID)
    let barBtnItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    
    detailVC.hidesBottomBarWhenPushed = true
    navigationItem.backBarButtonItem = barBtnItem
    navigationController?.pushViewController(detailVC, animated: true)
  }
  
  @objc private func receiveNotificationShowAll(_ notification: Notification) {
    guard let userInfo = notification.userInfo as? [String: Any],
      let requestKey = userInfo["requestKey"] as? RequestHome
      else { return }
    let showAllVC = ShowAllProductViewController()
    
    showAllVC.hidesBottomBarWhenPushed = true
    showAllVC.configure(requestKey: requestKey)
    navigationController?.pushViewController(showAllVC, animated: true)
  }
  
  @objc private func cartOrAlarmBtnTouched(_ notification: Notification) {
    guard
      let userInfo = notification.userInfo as? [String: Any],
      let product = userInfo["product"] as? MainItem
    else { return }
    let isSoldOut = false
    
    if !isSoldOut {
      let navigationController = UINavigationController(rootViewController: AddProductCartViewController())
      
      present(navigationController, animated: true) {
        navigationController.do {
          guard let firstViewController = $0.viewControllers.first as? AddProductCartViewController else { return }
          
          firstViewController.deliver(
            id: product.id,
            name: product.name,
            price: product.price,
            discountRate: product.discountRate
          )
        }
      }
    }
  }
}

extension HomeViewController: UITabBarControllerDelegate {
  func tabBarController(
    _ tabBarController: UITabBarController,
    didSelect viewController: UIViewController
  ) {
    guard let navi = viewController as? UINavigationController,
      let VC = navi.viewControllers[0] as? HomeViewController else { return }
    var moved = false
    let scrollView = VC.rootView.scrollView
    switch VC.rootView.selectedPage {
    case 0:
      guard let recommendationView = scrollView.subviews.first(
        where: { $0 as? RecommendationView != nil })
        as? RecommendationView
        else { return }
      if recommendationView.contentOffset.y != 0 {
        recommendationView.setContentOffset(.zero, animated: true)
        moved = true
      }
    case 1:
      guard let productView = scrollView.subviews.first(
        where: { ($0 as? NewProduct)?.collectionName == RequestHome.new })
        as? NewProduct
        else { return }
      if productView.contentOffset.y != 0 {
        productView.setContentOffset(.zero, animated: true)
        moved = true
      }
    case 2:
      guard let productView = scrollView.subviews.first(
        where: { ($0 as? NewProduct)?.collectionName == RequestHome.best })
        as? NewProduct
        else { return }
      if productView.contentOffset.y != 0 {
        productView.setContentOffset(.zero, animated: true)
        moved = true
      }
    case 3:
      guard let productView = scrollView.subviews.first(
        where: { ($0 as? NewProduct)?.collectionName == RequestHome.discount })
        as? NewProduct
        else { return }
      if productView.contentOffset.y != 0 {
        productView.setContentOffset(.zero, animated: true)
        moved = true
      }
    case 4:
      guard let eventView = scrollView.subviews.first(
        where: { $0 as? EventView != nil })
        as? EventView
        else { return }
      if eventView.contentOffset.y != 0 {
        eventView.setContentOffset(.zero, animated: true)
        moved = true
      }
    default:
      print("pass")
    }
    if !moved && scrollView.contentOffset.x != 0 {
      scrollView.setContentOffset(.zero, animated: true)
    }
  }
}
