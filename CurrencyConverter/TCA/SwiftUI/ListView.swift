//
//  ListView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/08/23.
//

import SwiftUI
import ComposableArchitecture

struct ListView: View {
  private let store: StoreOf<ListStore>
  init(store: StoreOf<ListStore>) {
    self.store = store
  }
    var body: some View {
      WithViewStore(self.store, observe: { $0 }) { viewStore in
        List(viewStore.tableViewDataArray, id: \.id) { tbd in
          CurrencyRowView(tableViewData: tbd)
        }
      }
    }
}

// struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//      ListView(store: sto)
//    }
// }
