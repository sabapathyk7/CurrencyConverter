//
//  CurrencyListView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencyListView: View {
    @State var tableViewData: [TableViewData]
    var body: some View {
      List {
          ForEach(tableViewData, id: \.id) { data in
            CurrencyRowView(tableViewData: data)
        }
      }
    }
}

struct CurrencyListView_Previews: PreviewProvider {
static var previews: some View {
      let tableViewData = TableViewData(currencyName: "name", currencyValue: 100.00399)
      let arrayOfTableViewData = [tableViewData, tableViewData]
      CurrencyListView(tableViewData: arrayOfTableViewData)
  }
}
