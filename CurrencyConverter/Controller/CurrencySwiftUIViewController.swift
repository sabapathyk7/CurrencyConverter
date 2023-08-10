//
//  CurrencySwiftUIViewController.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 10/08/23.
//

import UIKit
import SwiftUI

class CurrencySwiftUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      // Added HostingController to extract the CurrencySwiftUIView
      let hostingVC = UIHostingController(rootView: CurrencySwiftUIView())

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
