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
  var marginGuide: UILayoutGuide {
    return self.layoutMarginsGuide
  }
  var margingTop: NSLayoutYAxisAnchor {
    return self.layoutMarginsGuide.topAnchor
  }
  var marginBottom: NSLayoutYAxisAnchor {
    return self.layoutMarginsGuide.bottomAnchor
  }
  var marginLeading: NSLayoutXAxisAnchor {
    return self.layoutMarginsGuide.leadingAnchor
  }
  var marginTrailing: NSLayoutXAxisAnchor {
    return self.layoutMarginsGuide.trailingAnchor
  }
  var marginWidth: NSLayoutDimension {
    return self.layoutMarginsGuide.widthAnchor
  }
  var marginHeight: NSLayoutDimension {
    return self.layoutMarginsGuide.heightAnchor
  }
  var marginCenterX: NSLayoutXAxisAnchor {
    return self.layoutMarginsGuide.centerXAnchor
  }
  var marginCenterY: NSLayoutYAxisAnchor {
    return self.layoutMarginsGuide.centerYAnchor
  }

  struct AnchoredConstraints {
    var top, leading, bottom, trailing: NSLayoutConstraint?
  }
  struct AnchoredDimensions {
    var width, height: NSLayoutConstraint?

  }
  struct AnchoredCenteredConstraints {
    var centerX, centerY: NSLayoutConstraint?
  }
  func anchorCenter(centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?, inset: UIEdgeInsets = .zero) {
    translatesAutoresizingMaskIntoConstraints = false

    var anchoredCenteredConstraints = AnchoredCenteredConstraints()
    if let centerX = centerX {
      anchoredCenteredConstraints.centerX = centerXAnchor.constraint(equalTo: centerX)
    }
    if let centerY = centerY {
      anchoredCenteredConstraints.centerY = centerYAnchor.constraint(equalTo: centerY)
    }
    [anchoredCenteredConstraints.centerX, anchoredCenteredConstraints.centerY].forEach { $0?.isActive = true }
  }
  func anchorDimension(width: NSLayoutDimension?, height: NSLayoutDimension?, inset: UIEdgeInsets = .zero) {
    translatesAutoresizingMaskIntoConstraints = false

    var anchoredDimensions = AnchoredDimensions()
    if let width = width {
      anchoredDimensions.width = widthAnchor.constraint(equalTo: width, multiplier: inset.left, constant: inset.right)
    }
    if let height = height {
      anchoredDimensions.height = heightAnchor.constraint(equalTo: height, multiplier: inset.top, constant: inset.bottom)
    }
    [anchoredDimensions.width, anchoredDimensions.height].forEach { $0?.isActive = true }
  }

  func anchor(top: NSLayoutYAxisAnchor?,
              leading: NSLayoutXAxisAnchor?,
              bottom: NSLayoutYAxisAnchor?,
              trailing: NSLayoutXAxisAnchor?,
              inset: UIEdgeInsets = .zero) {

    translatesAutoresizingMaskIntoConstraints = false
    var anchoredConstraints = AnchoredConstraints()

    if let top = top {
      anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: inset.top)
    }
    if let leading = leading {
      anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: inset.left)
    }
    if let bottom = bottom {
      anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -inset.bottom)
    }
    if let trailing = trailing {
      anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -inset.right)
    }
    [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing].forEach { $0?.isActive = true }
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
