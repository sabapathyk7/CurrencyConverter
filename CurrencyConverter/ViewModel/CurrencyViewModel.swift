//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import Foundation

class CurrencyViewModel: ObservableObject {

  private var apiService: RequestService?
  @Published var tableViewData: [TableViewData] = [TableViewData]()

   init() {
    self.apiService = RequestService()
    tableViewData = fetchAPICall()
  }
  func fetchAPICall() -> [TableViewData] {
      callFetchCurrencyData { viewData in
        self.tableViewData = viewData
      }
      return tableViewData
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
