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
        ForEach(groupByCurrency(tableViewData), id: \.0) { pair in
          Section(header: Text(pair.0)) {
            ForEach(pair.1) { data in
              CurrencyRowView(tableViewData: data)
            }
          }
        }
      }.listStyle(.grouped)
    }

  func groupByCurrency(_ tableViewData: [TableViewData]) -> [(String, [TableViewData])] {
    let grouped = Dictionary(grouping: tableViewData, by: {String($0.currencyName.prefix(1))})
    return grouped.sorted(by: {$0.key < $1.key})
  }
}

struct CurrencyListView_Previews: PreviewProvider {
static var previews: some View {
      let tableViewData = TableViewData(currencyName: "name", currencyValue: 100.00399)
      let arrayOfTableViewData = [tableViewData, tableViewData]
      CurrencyListView(tableViewData: arrayOfTableViewData)
  }
}
