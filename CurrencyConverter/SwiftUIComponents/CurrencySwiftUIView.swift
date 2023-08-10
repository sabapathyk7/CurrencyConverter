//
//  CurrencySwiftUIView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencySwiftUIView: View {
    @State private var amount: String = ""
    @ObservedObject var viewModel =  CurrencyViewModel()
    private var currenciesArray: [TableViewData]?
    var body: some View {
      VStack {
              HStack(alignment: .center) {
                  TextField("Enter text", text: $amount).padding([.leading], 20)
                  Button("INR") {
                  }.padding([.trailing], 10)
                  Spacer()
              }
              CurrencyListView(currenciesArray: viewModel.tableViewData)
      }
    }
}

struct CurrencySwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySwiftUIView()
    }
}
