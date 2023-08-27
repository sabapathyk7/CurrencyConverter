//
//  ListEnvironment.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/08/23.
//

import Foundation

struct ListEnvironment {
  let currencyService: CurrencyServiceProtocol
  init(currencyService: CurrencyServiceProtocol) {
    self.currencyService = currencyService
  }
}
