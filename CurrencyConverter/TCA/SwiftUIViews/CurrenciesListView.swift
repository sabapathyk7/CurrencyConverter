//
//  ListView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/08/23.
//

import SwiftUI
import ComposableArchitecture

struct CurrenciesListView: View {
    let store: StoreOf<CurrenciesList>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List(viewStore.currencies, id: \.id) { tableViewData in
                CurrencyRowView(tableViewData: tableViewData)
            }
        }
    }
}

struct CurrenciesListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrenciesListView(store: .init(
            initialState: CurrenciesList.State(),
            reducer: { CurrenciesList() }
            )
        )
    }
}
