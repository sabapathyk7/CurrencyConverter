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
    button.setTitle("This is New Button. Press Me", for: .normal)
    button.backgroundColor = .yellow
    return button
  }()

  lazy var newLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = .brown
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
    backgroundColor = .white
//    stackView.addArrangedSubview(newButton)
//    stackView.addArrangedSubview(newLabel)
//    addSubViews([stackView])
    addSubViews([newButton, newLabel])
    setupLayout()
  }

  private func setupLayout() {
    let safeArea = self.layoutMarginsGuide
    newButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    newLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

    newButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    newLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    NSLayoutConstraint.activate([
      newButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
      newButton.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),

      newLabel.leadingAnchor.constraint(equalTo: newButton.trailingAnchor, constant: 5),
      newLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      newLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
    ])
  }
}
