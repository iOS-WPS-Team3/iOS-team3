//
//  EventView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class EventView: UITableView {
  var eventArray: HomeImages? {
    didSet {
      self.reloadData()
    }
  }
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    setupAttr()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    ObserverManager.shared.resignObserver(target: self, observerName: .bannerShared, object: nil)
  }
}

extension EventView {
  @objc private func receiveNotification(_ notification: Notification) {
    guard let banner = notification.object as? HomeImages else { return }
    eventArray = banner
  }
}

// MARK: - UI
extension EventView {
  private func setupAttr() {
    ObserverManager.shared.registerObserver(
      target: self, selector: #selector(receiveNotification(_:)), observerName: .bannerShared, object: nil)
    self.backgroundColor = .white
    self.dataSource = self
    self.separatorStyle = .none
    self.allowsSelection = false
    self.register(cell: EventTableViewCell.self)
  }
}

extension EventView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    eventArray?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let data = eventArray?[indexPath.row] else { return UITableViewCell() }
    let cell = EventTableViewCell()
    cell.configure(imageUrl: data)
    return cell
  }
}
