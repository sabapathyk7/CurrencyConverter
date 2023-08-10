//
//  CurrencySwiftUIView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencySwiftUIView: View {
  @State private var amount: String = ""
  @ObservedObject var viewModel = CurrencyViewModel()
    var body: some View {
      VStack {
        HStack {
          TextField("Enter text", text: $amount)
          Button("INR") {
          }
        }
        CurrencyListView(tableViewData: viewModel.arrayOfTableViewData)
      }.onAppear{
       await viewModel.someFunc()
      }
    }
}

struct CurrencySwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySwiftUIView()
    }
}
