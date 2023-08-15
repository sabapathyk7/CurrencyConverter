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
      HStack(alignment: .bottom) {
        VStack(alignment: .leading) {
          let locale = Locale.current
          Text(locale.localizedString(forCurrencyCode: tableViewData.currencyName) ?? "Indian Rupee" ).font(.caption)

          Text(tableViewData.currencyName).font(.subheadline).bold()
        }
        Spacer()
        Text(String(tableViewData.currencyValue)).font(.headline)
      }.padding()
    }
}

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        let tableViewData = TableViewData(base: "EUR", currencyName: "Name", currencyValue: 10.222)
        CurrencyRowView(tableViewData: tableViewData)
    }
}
