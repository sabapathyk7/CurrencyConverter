//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import Foundation

class CurrencyViewModel: NSObject {

  private var apiService: RequestService!
  private(set) var currencyData: [Currency]! {
    didSet {
      self.bindCurrencyViewModelToController()
    }
  }

  var bindCurrencyViewModelToController: (() -> ()) = {}

  override init() {
    super.init()
    self.apiService = RequestService()
    callFetchCurrencyData()
  }

  func callFetchCurrencyData() {
    self.apiService.fetchCurrencyData { (currencyData) in
      self.currencyData = currencyData
    }
  }

}
