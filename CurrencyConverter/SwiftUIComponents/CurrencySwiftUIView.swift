//
//  CurrencySwiftUIView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencySwiftUIView: View {
    @State private var amount: String = ""
    @State private var atableViewData = [TableViewData]()
    @ObservedObject var viewModel = CurrencyViewModel()
    var body: some View {
        VStack {
            HStack {
                TextField("Enter text", text: $amount)
                Button("INR") {}
            }.textFieldStyle(.roundedBorder).padding()
            Spacer()
            if atableViewData.count > 1 {
                CurrencyListView(tableViewData: atableViewData)
            }
        }.onAppear {
            Task {
              atableViewData = await viewModel.callFetchCurrencyDataSwiftUI()
            }
        }
    }
}

struct CurrencySwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySwiftUIView()
    }
}
