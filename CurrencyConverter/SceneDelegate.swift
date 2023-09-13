//
//  SceneDelegate.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import UIKit

enum RootView {
    case swiftui
    case uikit
    case tcaswiftui
    case tcauikit
}
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        guard let window = window as UIWindow? else {
            window?.makeKeyAndVisible()
            return
        }
        rootView(window: window, rootViewAction: RootView.swiftui)
    }
}

private extension SceneDelegate {
    func rootView(window: UIWindow, rootViewAction: RootView) {
        var viewController: UIViewController
        switch rootViewAction {
        case .swiftui:
            viewController = CurrencySwiftUIViewController()
        case .uikit:
            viewController = CurrencyViewController()

        case .tcaswiftui:
            viewController = CurrencyTCASwiftUIViewController()

        case .tcauikit:
            viewController = CurrencyTCAViewController(store: .init(initialState: .init(), reducer: {
                CurrencyConverter()
            }))
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
