//
//  ListStore.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/08/23.
//

import Foundation
import ComposableArchitecture

struct ListStore: Reducer {
  // MARK: - Environment
  private let environment: ListEnvironment = .init(currencyService: CurrencyService(session: .shared))
  // MARK: - State
  struct State: Equatable {
    var tableViewDataArray: [TableViewData]
  }
  // MARK: - Action
  enum Action: Equatable {
    case start
    case didScrollToBottom
    case onAppear(TableViewData)
    case currencyDataResponse(Result<CurrencyData, NAError>)
  }
  // Reducer
//  func reduce(into state: inout State, action: Action) -> Effect<Action> {
//    switch action {
//    case .start, .didScrollToBottom:
//      return .none
//    case .onAppear(let post):
//      return post == state.currencyListView.last ?
//      Effect.send(Action.didScrollToBottom) : .none
//    }
//  }

//  func reduce(into state: inout State, action: Action) -> Effect<Action> {
//    switch action {
//    case .didScrollToBottom:
//      return .none
//    case .onAppear:
//      return post == state.currencyListView.last ?
//      Effect.send(Action.didScrollToBottom) : .none
//    }
//  }
  // MARK: - Reducer
  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .start, .didScrollToBottom:
        return environment
          .currencyService
          .getCurrencyData()
          .receive(on: DispatchQueue.main)
          .catchToEffect(Action.currencyDataResponse)
      case let .currencyDataResponse(.success(currencyListView)):
        let currencyDet = self.fetchAllCurrencyDetails()
        var arrayOfTableViewData: [TableViewData] = [TableViewData]()
        for (key, value) in currencyListView.rates {
          guard let currencySymbol = currencyDet.filter({ $0.code.contains(key)}).last else {
            continue
          }
          let locale = Locale.current
          guard let currencyName = locale.localizedString(forCurrencyCode: key) else {
            continue
          }
          let tableViewData = TableViewData(base: "EUR", currencyCode: key,
                                            currencyName: currencyName,
                                            currencyValue: value, currencySymbol: currencySymbol.symbol)
          arrayOfTableViewData.append(tableViewData)
        }
        arrayOfTableViewData = arrayOfTableViewData.sorted(by: { tableViewData1, tableViewData2 in
          let currencyName1 = tableViewData1.currencyCode
          let currencyName2 = tableViewData2.currencyCode
          return (currencyName1.localizedCaseInsensitiveCompare(currencyName2) == .orderedAscending)
        })
        state.tableViewDataArray = arrayOfTableViewData
        return .none
      case let .currencyDataResponse(.failure(error)):
        print("❇️ Error:", error.localizedDescription)
        return .none
      case .onAppear(let currency):
        return currency == state.tableViewDataArray.last ?
        Effect.send(Action.didScrollToBottom) : .none
      }
    }
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
}
