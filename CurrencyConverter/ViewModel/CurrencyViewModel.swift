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

  func callFetchCurrencyData(completion: @escaping ([TableViewData]) -> ()) {
    self.apiService?.fetchCurrencyData { (currencyData) in
      var arrayOfTableViewData: [TableViewData] = [TableViewData]()
      for (key, value) in currencyData.rates {
        let tableViewData = TableViewData(currencyName: key, currencyValue: value)
        arrayOfTableViewData.append(tableViewData)
      }
      completion(arrayOfTableViewData)
    }
  }
}
