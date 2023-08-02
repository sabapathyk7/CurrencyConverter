//
//  CHCRLabelButtonView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 02/08/23.
//

import UIKit

class CHCRLabelButtonView: UIView {

  lazy var newButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Please press this Button ", for: .normal)
    button.backgroundColor = .black
    return button
  }()

  lazy var newLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = .black
    label.backgroundColor = .red
    label.text = "This is my Label"
    return label
  }()
  fileprivate lazy var stackView: UIStackView = {
    let hstackView = UIStackView()
    hstackView.axis = .horizontal
    hstackView.distribution = .fillProportionally
    hstackView.backgroundColor = .blue
    hstackView.translatesAutoresizingMaskIntoConstraints = false
    return hstackView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  private func setupView() {
    backgroundColor = .blue
    stackView.addArrangedSubview(newButton)
    stackView.addArrangedSubview(newLabel)
    addSubViews([stackView])
    setupLayout()
  }

  private func setupLayout() {
    let safeArea = self.layoutMarginsGuide

    newButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    newLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

    newButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    newLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    NSLayoutConstraint.activate([
      stackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
      stackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
    ])

  }

}
