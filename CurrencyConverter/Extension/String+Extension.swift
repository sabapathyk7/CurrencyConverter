//
//  String+Extension.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 15/08/23.
//

import Foundation

extension String {

  func validateGenericString(_ string: String) -> Bool {
    return string.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) == nil
  }
}
