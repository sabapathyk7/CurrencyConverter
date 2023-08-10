//
//  CurrencyListView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencyListView: View {
  @State var currenciesArray: [TableViewData]?
    var body: some View {
      List {
        ForEach(0..<currenciesArray!.count) { data in
          CurrencyRowView(tableViewData:
                            TableViewData(currencyName: currenciesArray?[data].currencyName
                                          ?? "USD", currencyValue: currenciesArray?[data].currencyValue ?? 22.2222))
        }
      }
    }
}

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView()
    }
}
