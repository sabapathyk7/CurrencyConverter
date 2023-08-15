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
    @Published var arrayOfTableViewData: [TableViewData] = [TableViewData]()
    
    // Inputs
    @Published var enteredAmount: String = ""
    @Published var selectedBaseCurrency: String = "EUR"
        
    init(apiService: RequestService? = RequestService()) {
        self.apiService = apiService
        setupSubscribers()
    }
    
    func callFetchCurrencyData(completion: @escaping ([TableViewData], [String]) -> Void) {
        self.apiService?.fetchCurrencyData { (currencyData) in
            var arrayOfCurrencyNames: [String] = [String]()
            var arrayOfTableViewData: [TableViewData] = [TableViewData]()
            for (key, value) in currencyData.rates {
                let tableViewData = TableViewData(base: self.selectedBaseCurrency,
                                                  currencyName: key,
                                                  currencyValue: value)
                arrayOfTableViewData.append(tableViewData)
                arrayOfCurrencyNames.append(key)
            }
            arrayOfTableViewData = arrayOfTableViewData.sorted(by: { aTableViewData, bTableViewData in
                let aCurrencyName = aTableViewData.currencyName
                let bCurrencyName = bTableViewData.currencyName
                return (aCurrencyName.localizedCaseInsensitiveCompare(bCurrencyName) == .orderedAscending)
            })
            self.arrayOfTableViewData = arrayOfTableViewData
            completion(arrayOfTableViewData, arrayOfCurrencyNames)
        }
    }
    
    func callFetchCurrencyDataSwiftUI() {
        self.apiService?.fetchCurrencyData { (currencyData) in
            var arrayOfTableViewDataLocal: [TableViewData] = [TableViewData]()
            for (key, value) in currencyData.rates {
                let tableViewData = TableViewData(base: self.selectedBaseCurrency,
                                                  currencyName: key,
                                                  currencyValue: value)
                arrayOfTableViewDataLocal.append(tableViewData)
            }
            arrayOfTableViewDataLocal = arrayOfTableViewDataLocal.sorted(by: { aTableViewData, bTableViewData in
                let aCurrencyName = aTableViewData.currencyName
                let bCurrencyName = bTableViewData.currencyName
                return (aCurrencyName.localizedCaseInsensitiveCompare(bCurrencyName) == .orderedAscending)
            })
            DispatchQueue.main.async {
                self.arrayOfTableViewData = arrayOfTableViewDataLocal
            }
        }
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
        //self.arrayOfTableViewData = computedTableViewData
    }
    
    func reactToEnteredAmount(_ amount: Double) {
        let computedTableViewData = arrayOfTableViewData.map { data in
            return TableViewData(base: selectedBaseCurrency,
                                 currencyName: data.currencyName,
                                 currencyValue: data.currencyValue * amount)
        }
        self.arrayOfTableViewData = computedTableViewData
    }
}
