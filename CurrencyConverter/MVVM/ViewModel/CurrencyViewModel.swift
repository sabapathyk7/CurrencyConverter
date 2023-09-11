//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import Combine
import Foundation

@MainActor class CurrencyViewModel: ObservableObject {
    private var apiService: RequestService?
    private var cancellable = Set<AnyCancellable>()
    // Outputs
    @Published var tableViewDataArray: [TableViewData] = [TableViewData]()
    // Inputs
    @Published var enteredAmount: String = ""
    @Published var selectedBaseCurrency: String = "EUR"
    var tempTableViewDataArray: [TableViewData] = [TableViewData]()
    let locale: Locale? = Locale.current

    init(apiService: RequestService? = RequestService()) {
        self.apiService = apiService
        setupSubscribers()
    }
    func fetchAllCurrencyDetails() -> [Currency] {
      var currencyDet: [Currency] = [Currency]()
      for localeID in Locale.availableIdentifiers {
        let locale = Locale(identifier: localeID)
        guard let currencyCode = locale.currency?.identifier, let currencySymbol = locale.currencySymbol else {
          continue
        }
        if !currencySymbol.validateGenericString(currencySymbol) {
          let filter = currencyDet.filter { $0.code.contains(currencyCode) }
          if filter.isEmpty {
            currencyDet.append(Currency(code: currencyCode, symbol: currencySymbol))
          }
        }
      }
      return currencyDet
    }
    func callFetchCurrencyData(base: String, completion: @escaping ([TableViewData]) -> Void) {
        self.apiService?.fetchCurrencyData(baseCurrency: base) { [self] (currencyData) in
         let resultData = self.sortTableViewDataDetails(currencyData: currencyData)
        completion(resultData)
        }
    }
    func callFetchCurrencyDataSwiftUI(base: String) {
        self.apiService?.fetchCurrencyData(baseCurrency: base) { (currencyData) in
         _ =  self.sortTableViewDataDetails(currencyData: currencyData)
        }
    }
  func convertCurrency(by updatingValue: String, currenciesDict: [String: [TableViewData]]?) -> [String: [TableViewData]] {
    guard let currenciesDict = currenciesDict.map({ dict in
      var dict = dict
      var tempTableViewData: [TableViewData] = [TableViewData]()
      _ = dict.map({ (key: String, value: [TableViewData]) in
        _ = value.map({ tvd in
          var tvd = tvd
          tvd.currencyValue.advance(by: Double(updatingValue) ?? 1.0)
          tempTableViewData.append(tvd)
        })
        dict.updateValue(tempTableViewData, forKey: key)
        tempTableViewData.removeAll()
      })
      return dict
    }) else {
      return [:]
    }
    return currenciesDict
  }
}

private extension CurrencyViewModel {
    func setupSubscribers() {
        $enteredAmount.sink { [weak self] string in
            print("⌨️ Typed Amount", string)
            guard let unwrappedSelf = self, let amount = Double(string) else {
                return
            }
            unwrappedSelf.reactToEnteredAmount(amount)
        }.store(in: &cancellable)
        $selectedBaseCurrency.sink { [weak self] string in
            print("💰 Selected Currency", string)
            guard let unwrappedSelf = self else {
                return
            }
            unwrappedSelf.reactToSelectedCurrency(string)
        }.store(in: &cancellable)
    }
}

private extension CurrencyViewModel {
    func reactToSelectedCurrency(_ currency: String) {
        self.apiService?.fetchCurrencyData(baseCurrency: currency) { (currencyData) in
         _ =  self.sortTableViewDataDetails(currencyData: currencyData)
        }
    }
    func reactToEnteredAmount(_ amount: Double) {
      tableViewDataArray = tempTableViewDataArray
      let computedTableViewData = tableViewDataArray.map { data in
          return TableViewData(base: selectedBaseCurrency, currencyCode: data.currencyCode,
                                 currencyName: data.currencyName,
                                 currencyValue: data.currencyValue * amount, currencySymbol: data.currencySymbol)
        }
        self.tableViewDataArray = computedTableViewData
    }
  func sortTableViewDataDetails(currencyData: CurrencyData) -> ([TableViewData]) {

    let currencyDet = self.fetchAllCurrencyDetails()
    var arrayOfTableViewData: [TableViewData] = [TableViewData]()
    for (key, value) in currencyData.conversion_rates {
      guard let currencySymbol = currencyDet.filter({ $0.code.contains(key)}).last else {
        continue
      }
      guard let currencyName = locale?.localizedString(forCurrencyCode: key) else {
        continue
      }
      let tableViewData = TableViewData(base: self.selectedBaseCurrency, currencyCode: key,
                                        currencyName: currencyName,
                                        currencyValue: value, currencySymbol: currencySymbol.symbol)
      arrayOfTableViewData.append(tableViewData)
    }
    arrayOfTableViewData = arrayOfTableViewData.sorted(by: { tableViewData1, tableViewData2 in
      return (tableViewData1.currencyCode.localizedCaseInsensitiveCompare(tableViewData2.currencyCode) == .orderedAscending)
    })
    DispatchQueue.main.async {
      self.tableViewDataArray = arrayOfTableViewData
    }
    self.tempTableViewDataArray = arrayOfTableViewData

    return arrayOfTableViewData
  }
}
