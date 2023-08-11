//
//  CurrencyRowView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencyRowView: View {
  @State var tableViewData: TableViewData
    var body: some View {
      HStack {
        VStack {
          Text(tableViewData.currencyName )
          Text(tableViewData.currencyName )
        }
        Text(String(tableViewData.currencyValue ))
      }
    }
}

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
      let tableViewData = TableViewData(currencyName: "Name", currencyValue: 10.222)
        CurrencyRowView(tableViewData: tableViewData)
    }
}
