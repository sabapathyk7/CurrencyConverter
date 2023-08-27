//
//  SceneDelegate.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        guard let window = window as UIWindow? else {
            window?.makeKeyAndVisible()
            return
        }
        rootViewTCASwiftUI(window: window)
        //    rootViewSwiftUI(window: )
        //    rootViewUIKit(window: window)
    }
    
    
}

private extension SceneDelegate {
    func rootViewUIKit(window: UIWindow) {
        let viewController = CurrencyViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func rootViewSwiftUI(window: UIWindow) {
        let viewController = CurrencySwiftUIViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func rootViewTCASwiftUI(window: UIWindow) {
        let viewController = CurrencyTCASwiftUIViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
