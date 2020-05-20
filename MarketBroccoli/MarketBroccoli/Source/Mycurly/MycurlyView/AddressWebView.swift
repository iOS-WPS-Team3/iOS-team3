//
//  AddressWebView.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/04.
//  Copyright © 2020 Team3. All rights reserved.
//
import UIKit
import WebKit

class AddressWebView: WKWebView {
  let indicator = UIActivityIndicatorView(style: .medium)
  var postCode = ""
  var address = ""
  let unwind = "unwind"
}
