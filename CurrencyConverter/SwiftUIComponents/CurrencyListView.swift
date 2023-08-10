//
//  CurrencyListView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencyListView: View {
  @State var tableViewData = [TableViewData]()
    var body: some View {
      List {
        ForEach(0..<tableViewData.count) {value in
          let data = tableViewData[value]
          CurrencyRowView(tableViewData: data)
        }
      }
    }
}

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView()
    }
}
