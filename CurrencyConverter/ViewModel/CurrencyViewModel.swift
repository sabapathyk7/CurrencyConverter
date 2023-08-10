//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import Foundation

@MainActor
class CurrencyViewModel: ObservableObject {
  private var apiService: RequestService?
  @Published var arrayOfTableViewData: [TableViewData] = [TableViewData]()

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

  func someFunc() async -> [TableViewData] {
    return await withCheckedContinuation { continuation in
      self.apiService?.fetchCurrencyData { (currencyData) in
        var arrayOfTableViewData: [TableViewData] = [TableViewData]()
        for (key, value) in currencyData.rates {
          let tableViewData = TableViewData(currencyName: key, currencyValue: value)
          arrayOfTableViewData.append(tableViewData)
        }
      }
      continuation.resume(returning: arrayOfTableViewData)
    }
  }
}
