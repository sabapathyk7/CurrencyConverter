//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import Foundation

struct CurrencyViewModel {

  private var apiService: RequestService?

   init() {
    self.apiService = RequestService()
  }

  func callFetchCurrencyData(completion: @escaping (CurrencyData) -> ()) {
    self.apiService?.fetchCurrencyData { (currencyData) in
      completion(currencyData)
    }
  }

}
