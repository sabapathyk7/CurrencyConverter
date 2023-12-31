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
          Text(tableViewData.currencyName ).font(.caption)
          Text(tableViewData.currencyCode + tableViewData.currencyCode.dropLast().description.countryFlag()).font(.subheadline).bold()
        }
        Spacer()
        Text(String(format: "%.2f", tableViewData.currencyValue.rounded(toPlaces: 2))).font(.headline)
      }.padding()
    }
}

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
      let tableViewData = TableViewData(base: "EUR",
                                        currencyCode: "EUR",
                                        currencyName: "Euro",
                                        currencyValue: 10.222,
                                        currencySymbol: "$")
        CurrencyRowView(tableViewData: tableViewData)
    }
}
