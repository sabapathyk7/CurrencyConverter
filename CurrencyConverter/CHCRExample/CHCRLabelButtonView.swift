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
    button.setTitle("Press ME!", for: .normal)
    button.backgroundColor = .red
    return button
  }()

  lazy var newLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = .brown
    label.backgroundColor = .lightGray
    label.text = "This is my new Label. Grow with me."
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

    /* // -> Example of CH and CR
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
     */

    /*
     // -> Example of Multiplier
    NSLayoutConstraint.activate([
      newLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
      newLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
      // Setting with multiplier for the label - 50% of view's width
      newLabel.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5)
    ])

    NSLayoutConstraint.activate([
      newButton.centerXAnchor.constraint(equalTo: newLabel.centerXAnchor),
      newButton.centerYAnchor.constraint(equalTo: newLabel.centerYAnchor, constant: 50),
      // Setting with multiplier for the label - 50% of label's width
      newButton.widthAnchor.constraint(equalTo: newLabel.widthAnchor, multiplier: 0.5),
      // Setting with multiplier for the label - 80% of heigth's width
      newButton.heightAnchor.constraint(equalTo: newLabel.heightAnchor, multiplier: 0.5)
    ])
     */

    NSLayoutConstraint.activate([
      // Leading and top anchors of the Label
      newLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
      newLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),

      // Leading align with newLabel
      newButton.leadingAnchor.constraint(equalTo: newLabel.leadingAnchor),
      // Trailing align with newLabel (20 points below)
      newButton.trailingAnchor.constraint(equalTo: newLabel.trailingAnchor, constant: -20),

      // below the newLabel
      newButton.topAnchor.constraint(equalTo: newLabel.bottomAnchor, constant: 20),
      // aligned with the bottom edges of the superview
      newButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
    ])
  }
}
