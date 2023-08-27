//
//  CurrencyRowView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencyRowView: View {
  @State var tableViewData: TableViewData
  let locale = Locale.current
  var body: some View {
      HStack(alignment: .bottom) {
        VStack(alignment: .leading) {
          Text(tableViewData.currencyName ).font(.caption)
          Text(tableViewData.currencyCode).font(.subheadline).bold()
        }
        Spacer()
        Text(tableViewData.currencySymbol + String(tableViewData.currencyValue)).font(.headline)
      }.padding()
    }
}

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
      let tableViewData = TableViewData(base: "EUR", currencyCode: "EUR", currencyName: "Euro", currencyValue: 10.222, currencySymbol: "$")
        CurrencyRowView(tableViewData: tableViewData)
    }
}
