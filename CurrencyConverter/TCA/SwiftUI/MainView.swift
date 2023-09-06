//
//  MainView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/08/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
      AppView(
        store: .init(
          initialState: .initial,
          reducer: AppStore()
        )
      )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
