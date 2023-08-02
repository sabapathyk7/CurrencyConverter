//
//  UIView+Extension.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 29/07/23.
//

import UIKit

extension UIView {
  // Adding multiple subviews to the view
  func addSubViews(_ views: [UIView]) {
    for view in views {
      addSubview(view)
    }
  }
  func pinToEdges(of superView: UIView, useSafeArea: Bool = false, constant: CGFloat = 0) {
    self.translatesAutoresizingMaskIntoConstraints = false
    if useSafeArea {
      NSLayoutConstraint.activate([
        leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: constant),
        trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -constant),
        topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: constant),
        bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -constant)
      ])
    } else {
      NSLayoutConstraint.activate([
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: constant),
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -constant),
        topAnchor.constraint(equalTo: superView.topAnchor, constant: constant),
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -constant)
      ])
    }
  }
  func pinToLayoutGuide(layoutGuide: UILayoutGuide, constant: CGFloat) {
    self.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: constant),
      trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -constant),
      topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: constant),
      bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -constant)
    ])
  }
}
