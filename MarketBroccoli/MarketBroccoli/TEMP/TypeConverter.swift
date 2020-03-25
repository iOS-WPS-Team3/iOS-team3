//
//  TypeConverter.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

func moneyFormatter(won: Int, hasUnit: Bool) -> String {
      let numberFormatter = NumberFormatter().then {
        $0.numberStyle = .decimal
      }
      guard let converted = numberFormatter.string(from: NSNumber(value: won)) else { fatalError("Currency Convert Error") }
      let result = hasUnit ? converted+"원" : converted
      return result
    }
    
    func dateFormat(date: Date) -> String {
      
      let formatter = DateFormatter().then {
        $0.dateFormat =  "yyyy년 MM월 dd일"
      }
      let dateString = formatter.string(from: date)
      return dateString
    }

