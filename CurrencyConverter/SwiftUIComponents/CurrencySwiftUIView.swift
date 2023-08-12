//
//  CurrencySwiftUIView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencySwiftUIView: View {
    @State private var amount: String = "1"
    @State private var selectedCurrency: String = "INR"
    @State private var atableViewData = [TableViewData]()
    @State private var pickerNames = [String]()
    @ObservedObject var viewModel = CurrencyViewModel()
    var body: some View {
        VStack {
          HStack {
            TextField("Enter text", text: $amount).textFieldStyle(.roundedBorder).padding()
            Spacer()
            if pickerNames.count > 1 {
              Picker("Currency", selection: $selectedCurrency) {
                ForEach(pickerNames, id: \.self) {
                  Text($0)
                }
              }.pickerStyle(.menu)
            }
          }
          Spacer()
          if atableViewData.count > 1 {
            CurrencyListView(tableViewData: atableViewData)
          }
        }.onAppear {
          Task {
            let tuple = await viewModel.callFetchCurrencyDataSwiftUI()
            atableViewData = tuple.0
            pickerNames = tuple.1
          }
        }
    }
}

struct CurrencySwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
      CurrencySwiftUIView()
    }
}
