//
//  UIViewControllerExtension.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/27.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UIViewController {
  func setupBroccoliNavigationBar(title: String) {
    self.title = title
    
    if title == "마켓브로콜리" {
      let marketBroccoliImage = UIImage(named: "marketBroccoli")
      
      let imageView = UIImageView(image: marketBroccoliImage).then {
        $0.contentMode = .scaleAspectFit
      }
      
      navigationItem.titleView = imageView
    }
    
    guard let navigationController = navigationController else { return }
    
    navigationController.do {
      $0.navigationBar.barTintColor = .kurlyMainPurple
      $0.navigationBar.tintColor = .white
      $0.navigationBar.barStyle = .black
      $0.navigationBar.isTranslucent = false
      $0.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView:
      UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    )
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView:
      UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    )
  }
  
  func setupSubNavigationBar(title: String) {
    self.title = title
    
    navigationController?.do({
      $0.navigationBar.tintColor = .black
      $0.navigationBar.barStyle = .default
      $0.navigationBar.shadowImage = UIImage()
      $0.navigationBar.barTintColor = .white
      $0.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    })
  }
  
  @objc
  fileprivate func presentCartViewController() {
    let cartViewController = UINavigationController(rootViewController: CartViewController()).then {
      $0.modalPresentationStyle = .fullScreen
      $0.modalTransitionStyle = .coverVertical
    }
    
    present(cartViewController, animated: true)
  }
  
  func addNavigationBarCartButton() {
    let cartButton = UIButton(type: .system).then { button in
      func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        guard let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return newImage
      }
      
      CartManager.shared.fetchCartCount { result in
        switch result {
        case .success(let cartCount):
          let countImage = UIImage(systemName: "\(cartCount).circle.fill")
          let cartImage = UIImage(systemName: "cart")
          
          let size = CGSize(width: 100, height: 100)
          UIGraphicsBeginImageContext(size)
          
          let cartAreaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height - 20)
          let cartSizeAreaSize = CGRect(
            x: size.width - size.width / 2.1, y: 0, width: size.width / 2, height: size.height / 2
          )
          cartImage?.draw(in: cartAreaSize, blendMode: .normal, alpha: 1)
          if cartCount > 0 {
            countImage?.draw(in: cartSizeAreaSize, blendMode: .clear, alpha: 1)
            countImage?.draw(in: cartSizeAreaSize, blendMode: .normal, alpha: 1)
          }
          
          guard let cartWithSizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
          UIGraphicsEndImageContext()
          let resizedImage = imageWithImage(image: cartWithSizeImage, scaledToSize: CGSize(width: 32, height: 32))
          
          button.setImage(resizedImage, for: .normal)

          button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
          button.imageView?.contentMode = .scaleAspectFit
          
          self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        case .failure(let error):
          let cartImage = UIImage(systemName: "cart")
          let resizedImage = imageWithImage(image: cartImage ?? UIImage(), scaledToSize: CGSize(width: 32, height: 32))
          
          button.setImage(resizedImage, for: .normal)
          self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
          print(error.localizedDescription)
        }
      }
      
      button.addTarget(self, action: #selector(presentCartViewController), for: .touchUpInside)
    }
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
  }
  
  func addSubNavigationBarCartButton() {
    let cartButton = UIButton(type: .system).then {
      $0.tintColor = .black
      $0.setImage(UIImage(systemName: "cart"), for: .normal)
      
      $0.addTarget(self, action: #selector(presentCartViewController), for: .touchUpInside)
    }
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
  }
}
