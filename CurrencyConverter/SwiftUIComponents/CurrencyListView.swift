//
//  CurrencyListView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencyListView: View {
    var body: some View {
      List {
        ForEach(1..<20) {_ in
          CurrencyRowView()
        }
      }
    }
}

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView()
    }
}
