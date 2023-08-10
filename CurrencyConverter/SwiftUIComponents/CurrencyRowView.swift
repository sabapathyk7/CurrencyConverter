//
//  CurrencyRowView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import SwiftUI

struct CurrencyRowView: View {
    var body: some View {
      HStack {
        VStack {
          Text("Singapore Dollar")
          Text("AED")
        }
        Text(String(5.323243324))
      }
    }
}

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView()
    }
}
