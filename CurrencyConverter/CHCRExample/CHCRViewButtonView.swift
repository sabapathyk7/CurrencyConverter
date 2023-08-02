//
//  CHCRViewButtonView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 02/08/23.
//

import UIKit

class CHCRViewButtonView: UIView {

  lazy var newButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Ok", for: .normal)
    return button
  }()

  lazy var newLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = .black
    return label
  }()



}
