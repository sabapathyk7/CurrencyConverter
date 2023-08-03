//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import UIKit

class CurrencyCellView: UIView {

  private let locale = Locale.current
  private lazy var stackView: UIStackView = {
    let vstackView = UIStackView()
    vstackView.axis = .vertical
    vstackView.distribution = .fillEqually
    vstackView.backgroundColor = .red
    vstackView.translatesAutoresizingMaskIntoConstraints = false
    return vstackView
  }()

  private lazy var currencyNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .left
    label.textColor = .black
    return label
  }()

  private lazy var currencyCodeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .left
    label.textColor = .black
    return label
  }()

  private lazy var currencyRateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .blue
    label.backgroundColor = .gray
    return label
  }()

  init() {
    super.init(frame: CGRect.zero)
    self.backgroundColor = .blue
    self.translatesAutoresizingMaskIntoConstraints = false
    setupUI()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  private func setupUI() {
    stackView.addArrangedSubview(currencyNameLabel)
    stackView.addArrangedSubview(currencyCodeLabel)
    self.addSubViews([stackView, currencyRateLabel])

    let safeArea = self.layoutMarginsGuide
    stackView.pinToLayoutGuide(layoutGuide: safeArea, constant: 1.0)
    NSLayoutConstraint.deactivate([stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -1.0)])
    stackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.7).isActive = true
    currencyRateLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 1.0).isActive = true
    currencyRateLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
  }
  fileprivate func update(with key: String, value: String) {
    currencyCodeLabel.text = key
    currencyRateLabel.text = value
    currencyNameLabel.text = locale.localizedString(forCurrencyCode: key)
  }
}
class CurrencyCell: UITableViewCell {

  static let identifier = "CurrencyCell"
  private var currencyCellView = CurrencyCellView()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.currencyCellView = CurrencyCellView()
    contentView.addSubview(currencyCellView)
    currencyCellView.pinToLayoutGuide(layoutGuide: contentView.layoutMarginsGuide, constant: 0)
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  func update(with key: String, value: String) {
    currencyCellView.update(with: key, value: value)
  }
}

class CurrencyCollectionViewCell: UICollectionViewCell {

  private let locale = Locale.current
  static let identifier = "CurrencyCollectionViewCell"
  private var currencyCellView = CurrencyCellView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.currencyCellView = CurrencyCellView()
    contentView.addSubview(currencyCellView)
    currencyCellView.pinToLayoutGuide(layoutGuide: contentView.layoutMarginsGuide, constant: 10)
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  func update(with key: String, value: String) {
    currencyCellView.update(with: key, value: value)
  }
}
