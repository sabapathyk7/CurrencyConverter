//
//  CurrencyTCASwiftUIViewController.swift
//  CurrencyConverter
//
//  Created by Muralidharan Kathiresan on 28/08/23.
//

import SwiftUI
import UIKit

class CurrencyTCASwiftUIViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let rootView = CurrencyConverterView(
            store: .init(initialState: .init(),
                         reducer: { CurrencyConverter() })
          )
        let hostingVC = UIHostingController(rootView: rootView)
        guard let hostingVC = hostingVC as? UIHostingController else {
            return
        }
        guard let swiftUIView = hostingVC.view else {
            return
        }
        swiftUIView.translatesAutoresizingMaskIntoConstraints = false
        // add HostingVC to destination VC
        addChild(hostingVC)
        // add SwiftUIView to view's Hierarchy
        view.addSubview(swiftUIView)
        // Adding Constraints to Layout Guide
        swiftUIView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           leading: view.safeAreaLayoutGuide.leadingAnchor,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           trailing: view.safeAreaLayoutGuide.trailingAnchor)
        // To notify if that the transition is complete
        hostingVC.didMove(toParent: self)
    }
}
