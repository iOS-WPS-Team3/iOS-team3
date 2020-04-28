//
//  UILabelExtension.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UILabel {
  func getWidth() -> CGFloat? {
    if let title = self.text, let font = self.font {
      let attr = [NSAttributedString.Key.font: font]
      return (title as NSString).size(withAttributes: attr).width
    }
    return nil
  }
  
  func strikethrough() {
    guard let text = self.text else { return }
    let attribute: NSMutableAttributedString = NSMutableAttributedString(string: text)
    attribute.addAttribute(
      NSAttributedString.Key.strikethroughStyle,
      value: 2,
      range: NSRange(location: 0, length: attribute.length)
    )
    self.attributedText = attribute
  }
  
  func lineSpacing(_ spacing: CGFloat) {
    guard let text = self.text else { return }
    let attribute: NSMutableAttributedString = NSMutableAttributedString(string: text)
    
    let style = NSMutableParagraphStyle()
    style.lineSpacing = spacing
    attribute.addAttribute(
      NSAttributedString.Key.paragraphStyle,
      value: style,
      range: NSRange(location: 0, length: attribute.length)
    )
    self.attributedText = attribute
  }
}

extension String {
  func strikeThrough() -> NSAttributedString {
    let attributeString = NSMutableAttributedString(string: self)
    attributeString.addAttribute(
      NSAttributedString.Key.strikethroughStyle,
      value: NSUnderlineStyle.single.rawValue,
      range: NSRange(location: 0, length: attributeString.length))
    return attributeString
  }
}
