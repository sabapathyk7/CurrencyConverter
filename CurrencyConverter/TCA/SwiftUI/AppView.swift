//
//  AppView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/08/23.
//

import SwiftUI
import ComposableArchitecture
struct AppView: View {
    let store: StoreOf<AppStore>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ListView(
                store: store.scope(
                    state: \.listState,
                    action: AppStore.Action.list)
            )
            .onAppear {
                viewStore.start()
            }
        }
    }
}

// struct AppView_Previews: PreviewProvider {
//    static var previews: some View {
//      AppView(store: <#StoreOf<AppStore>#>)
//    }
// }

fileprivate extension ViewStore<AppStore.State, AppStore.Action> {
  func start() {
    send(.list(.start))
  }
}
