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

    func callFetchCurrencyData(completion: @escaping ([TableViewData], [String]) -> Void) {
        self.apiService?.fetchCurrencyData { (currencyData) in
            var arrayOfCurrencyNames: [String] = [String]()
            var arrayOfTableViewData: [TableViewData] = [TableViewData]()
            for (key, value) in currencyData.rates {
                let tableViewData = TableViewData(currencyName: key, currencyValue: value)
                arrayOfTableViewData.append(tableViewData)
                arrayOfCurrencyNames.append(key)
            }
          arrayOfTableViewData = arrayOfTableViewData.sorted(by: { aTableViewData, bTableViewData in
            let aCurrencyName = aTableViewData.currencyName
            let bCurrencyName = bTableViewData.currencyName
            return (aCurrencyName.localizedCaseInsensitiveCompare(bCurrencyName) == .orderedAscending)
          })
          completion(arrayOfTableViewData, arrayOfCurrencyNames)
        }
    }

    func callFetchCurrencyDataSwiftUI() async -> ([TableViewData], [String]) {
        return await withCheckedContinuation({ continuation in
            self.apiService?.fetchCurrencyData { (currencyData) in
              var arrayOfTableViewDataLocal: [TableViewData] = [TableViewData]()
              var arrayOfCurrencyNames: [String] = [String]()
                for (key, value) in currencyData.rates {
                    let tableViewData = TableViewData(currencyName: key, currencyValue: value)
                  arrayOfTableViewDataLocal.append(tableViewData)
                  arrayOfCurrencyNames.append(key)
                }
              arrayOfTableViewDataLocal = arrayOfTableViewDataLocal.sorted(by: { aTableViewData, bTableViewData in
                let aCurrencyName = aTableViewData.currencyName
                let bCurrencyName = bTableViewData.currencyName
                return (aCurrencyName.localizedCaseInsensitiveCompare(bCurrencyName) == .orderedAscending)
              })
              continuation.resume(returning: (arrayOfTableViewDataLocal, arrayOfCurrencyNames.sorted()))
            }
        })
    }
}
