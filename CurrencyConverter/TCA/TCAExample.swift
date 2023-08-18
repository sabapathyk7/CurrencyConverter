//
//  TCAExample.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 13/08/23.
//

import Foundation
import ComposableArchitecture

struct CurrencyFeature: Reducer {
  func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
    return .none
  }
  struct State: Equatable {
    var currencyName: String
    var currencyValue: Double
  }
  enum Action: Equatable {
    case showCurrencyName
    case showCurrencyValue
  }
}
