//
//  CurrencyRowView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencyRowView: View {
  private let locale = Locale.current
  @State var tableViewData: TableViewData?
    var body: some View {
      HStack(alignment: .top) {
        VStack(alignment: .leading) {
          Text(locale.localizedString(forCurrencyCode: tableViewData?.currencyName ?? "Singapore Dollar") ?? "Singapore Dollar")
            .padding([.bottom, .trailing], 5)
          Text(tableViewData?.currencyName ?? "AED").font(.subheadline).fontWeight(.bold)
        }
        Text(String(tableViewData?.currencyValue ?? 5.323243324)).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing).padding()
      }
    }
}

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView()
    }
}
