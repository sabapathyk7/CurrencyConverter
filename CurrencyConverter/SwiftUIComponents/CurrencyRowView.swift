//
//  CurrencyRowView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencyRowView: View {
  @State var tableViewData: TableViewData?
    var body: some View {
      HStack {
        VStack {
          Text(tableViewData?.currencyName ?? "Indian Rupee")
          Text(tableViewData?.currencyName ?? "INR")
        }
        Text(String(tableViewData?.currencyValue ?? 56.0000))
      }
    }
}

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView()
    }
}
