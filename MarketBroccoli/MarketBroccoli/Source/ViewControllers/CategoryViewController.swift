//
//  CategoryViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Alamofire

class CategoryViewController: UIViewController {
  // MARK: - Properties
  private var tableView = UITableView(frame: .zero, style: .grouped)
//  private var tableView = UITableView()
  private let oftenProduct = ["자주 사는 상품"]
  private var lastSelection: IndexPath?
  private var refreshControl = UIRefreshControl()
  private var dummyData: CategoryModel2? = nil
// MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
    setupUI()
    setupLayout()    
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.addNavigationBarCartButton()
  }
  
  private func dataRequest(categoryId: Int) {
    RequestManager.shared.categoryRequest(url: .initial, method: .get, categoryId: categoryId) { result in
      switch result {
      case .success(let data):
        print(data)
      case .failure(let error):
        print(error)
      }
    }
  }
  
  // MARK: - Setup Attribute
  private func setupNavigation() {
    self.setupBroccoliNavigationBar(title: "카테고리")
  }
  private func setupUI() {
    self.tabBarController?.delegate = self
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableHeaderView =
      UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height) * 0.01))
    tableView.tableFooterView =
      UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height) * 0.01))
    tableView.separatorStyle = .none // 테이블 뷰 라인 없애기
    tableView.register(cell: CategoryTableViewCell.self)
    tableView.register(cell: CategorySubTableViewCell.self)
    tableView.register(cell: RecommendationTableViewCell.self)
    tableView.register(cell: UITableViewCell.self)
    [tableView].forEach {
      view.addSubview($0)
    }
    if #available(iOS 10.0, *) {
      tableView.refreshControl = refreshControl
    } else {
      tableView.addSubview(refreshControl)
    }
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
  }
  
  private func setupLayout() {
    let guide = view.safeAreaLayoutGuide
    tableView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(guide)
    }
  }
//  private func downloadData(success: @escaping ()->()){
//    Alamofire.request(URL).responseJSON{ (response) in
//    /*
//       Download Data
//      */
//      success()
//    }
//  }
   @objc private func refresh() {
//    downloadData {
      /*
      success 메소드 정의
      */
      self.refreshControl.endRefreshing()
//    }
  }
}

// MARK: - TableViewDataSource
extension CategoryViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return categoryData.count + 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0, categoryData.count + 1:
      return 1
    default:
      if categoryData[section - 1].select {
        return categoryData[section - 1].row.count + 1
      } else {
        return 1
      }
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let image = UIImageView(image: UIImage(systemName: "chevron.right"))
      let cell = tableView.dequeue(UITableViewCell.self).then {
        $0.textLabel?.text = oftenProduct[indexPath.section]
        $0.textLabel?.textColor = #colorLiteral(red: 0.3176470588, green: 0.1529411765, blue: 0.4470588235, alpha: 1)
        $0.accessoryView = image
        $0.accessoryView?.tintColor = #colorLiteral(red: 0.3176470588, green: 0.1529411765, blue: 0.4470588235, alpha: 1)
      }
      return cell
    case categoryData.count + 1:
      let cell = tableView.dequeue(RecommendationTableViewCell.self)
      return cell
    default:
      if indexPath.row == 0 {
        let data = categoryData[indexPath.section - 1]
        let cell = tableView.dequeue(CategoryTableViewCell.self).then {
          $0.titleName(name: data.title)
          $0.selectState(data: data)
        }
        return cell
      } else {
        let data =
        categoryData[indexPath.section - 1].row[indexPath.row - 1]
        let cell = tableView.dequeue(CategorySubTableViewCell.self).then {
          $0.titleName(name: data)
          $0.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        }
        return cell
      }
    }
  }
}

// MARK: - TableViewDelegate
extension CategoryViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath)
    switch indexPath.section {
    case 0:
      let buyOftenViewController = BuyOftenViewController()
      self.navigationController?.pushViewController(buyOftenViewController, animated: true)
    case categoryData.count + 1:
      print(indexPath.section)
    default:
      switch indexPath.row {
      case 0:
        var sections: IndexSet = []
        if let lastSection = lastSelection?.section {
          categoryData[lastSection - 1].select = false
          sections.insert(lastSection)
        }
        if lastSelection == indexPath {
          lastSelection = nil
        } else {
          lastSelection = indexPath
          categoryData[indexPath.section - 1].select.toggle()
          sections.insert(indexPath.section)
        }
        tableView.reloadSections(sections, with: .none)
      case 1:
        let categoryDetailVC = CategoryDetailViewController()
        let naviagationTitle = categoryData[indexPath.section - 1].title
        let selectedCellTitle = categoryData[indexPath.section - 1].row[indexPath.row - 1]
        categoryDetailVC.categoryDetailNavigationTitle = naviagationTitle
        categoryDetailVC.selectedCellTitle = selectedCellTitle
        categoryDetailVC.categoryId = indexPath.section
        categoryDetailVC.subCategoryId = 0
        self.navigationController?.pushViewController(categoryDetailVC, animated: true)
      default:
        let categoryDetailVC = CategoryDetailViewController()
        let naviagationTitle = categoryData[indexPath.section - 1].title
        let selectedCellTitle = categoryData[indexPath.section - 1].row[indexPath.row - 1]
        categoryDetailVC.categoryDetailNavigationTitle = naviagationTitle
        categoryDetailVC.selectedCellTitle = selectedCellTitle
        categoryDetailVC.categoryId = indexPath.section
        categoryDetailVC.subCategoryId = indexPath.row
        self.navigationController?.pushViewController(categoryDetailVC, animated: true)
        print(indexPath.row)
      }
    }
  }
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
   }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    switch section {
    case categoryData.count + 1:
      let headerView = CategorySectionHeaderView()
      return headerView
    default:
      return nil
    }
  }
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return " "
  }

  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return "footer"
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch section {
    case categoryData.count + 1:
      return 67
    default:
      return 0
    }
  }
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    switch section {
    case 0, categoryData.count:
      return 10
    default:
      return 0
    }
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 0:
      return 52
    default:
      return UITableView.automaticDimension
    }
   }
}

extension CategoryViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    tableView.setContentOffset(.zero, animated: true)
  }
}
