//
//  ListStore.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/08/23.
//

import Foundation
import ComposableArchitecture
import IdentifiedCollections

struct CurrenciesList: Reducer {
    struct State: Equatable {
        var currencies: [TableViewData] = []
    }
    
    enum Action: Equatable {
        case updateCurrencies([TableViewData])
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}
