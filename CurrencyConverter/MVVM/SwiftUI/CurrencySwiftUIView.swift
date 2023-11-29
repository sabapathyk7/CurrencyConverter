//
//  CurrencySwiftUIView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencySwiftUIView: View {
    @ObservedObject var viewModel = CurrencyViewModel()
    @State var isHidden = false
    var body: some View {
        VStack {
            if isHidden {
                HStack {
                    TextField("Enter text", text: $viewModel.enteredAmount)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    Spacer()
                    Picker("Currency", selection: $viewModel.selectedBaseCurrency) {
                        Text(viewModel.selectedBaseCurrency).tag(viewModel.selectedBaseCurrency)
                        ForEach(viewModel.tableViewDataArray, id: \.self) {
                            Text($0.currencyCode).tag($0.currencyCode)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .progressViewStyle(.circular)
                Spacer()
                CurrencyListView(tableViewData: $viewModel.tableViewDataArray)
            } else {
                ProgressView("Loading")
            }
        }
        .onAppear {
            Task {
                viewModel.callFetchCurrencyDataSwiftUI(base: viewModel.selectedBaseCurrency)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                isHidden = true
            })
        }
    }
}

struct CurrencySwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySwiftUIView()
    }
}
