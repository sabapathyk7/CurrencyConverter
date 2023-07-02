//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import Foundation

class CurrencyViewModel {

  private var apiService: RequestService?
  private(set) var currencyData: CurrencyData? {
    didSet {
      self.bindCurrencyViewModelToController()
    }
  }

  var bindCurrencyViewModelToController: (() -> ()) = {}

   init() {
    self.apiService = RequestService()
    callFetchCurrencyData()
  }

  func callFetchCurrencyData() {
    self.apiService?.fetchCurrencyData { (currencyData) in
    self.currencyData = currencyData
    } 
  }

}
