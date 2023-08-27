//
//  AppStore.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/08/23.
//

import Foundation
import ComposableArchitecture

struct AppStore: Reducer {

  struct State: Equatable {
    var listState: ListStore.State
    static let initial: Self = .init(
      listState: .init(tableViewDataArray: [])
    )
  }

  enum Action: Equatable {

    case list(ListStore.Action)
  }

  var body: some ReducerProtocolOf<Self> {
    Reduce { state, action in
      switch action {
      case .list:
        return .none
      }
    }
    Scope(
      state: \State.listState,
      action: /Action.list
    ) {
      ListStore()
    }
  }
//  func reduce(into state: inout State, action: Action) -> Effect<Action> {
//      switch action {
//      case .list:
//        return .none
//      }
//    Scope(state: \State.listState, action: /.list) {
//      ListStore()
//    }
//  }
}
