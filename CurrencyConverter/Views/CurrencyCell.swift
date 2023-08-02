//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import UIKit

class CurrencyCellView: UIView {

  fileprivate lazy var stackView: UIStackView = {
    let vstackView = UIStackView()
    vstackView.axis = .vertical
    vstackView.distribution = .fillEqually
    vstackView.backgroundColor = .red
    vstackView.translatesAutoresizingMaskIntoConstraints = false
    return vstackView
  }()

  fileprivate lazy var currencyNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .left
    label.textColor = .black
    return label
  }()

  fileprivate lazy var currencyCodeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .left
    label.textColor = .black
    return label
  }()

  fileprivate lazy var currencyRateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .blue
    label.backgroundColor = .gray
    return label
  }()
}
class CurrencyCell: UITableViewCell {

  private let locale = Locale.current
  static let identifier = "CurrencyCell"
  private let currencyCellView = CurrencyCellView()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {

    currencyCellView.stackView.addArrangedSubview(currencyCellView.currencyNameLabel)
    currencyCellView.stackView.addArrangedSubview(currencyCellView.currencyCodeLabel)
    contentView.addSubViews([currencyCellView.stackView, currencyCellView.currencyRateLabel])


    let safeArea = contentView.layoutMarginsGuide
    currencyCellView.stackView.pinToLayoutGuide(layoutGuide: safeArea, constant: 1.0)
    NSLayoutConstraint.deactivate([currencyCellView.stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -1.0)])
    currencyCellView.stackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 1.0).isActive = true
    currencyCellView.currencyRateLabel.leadingAnchor.constraint(equalTo: currencyCellView.stackView.trailingAnchor, constant: 1.0).isActive = true
    currencyCellView.currencyRateLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
  }
  func update(with key: String, value: String) {
    currencyCellView.currencyCodeLabel.text = key
    currencyCellView.currencyRateLabel.text = value
    currencyCellView.currencyNameLabel.text = locale.localizedString(forCurrencyCode: key)
  }
}

class CurrencyCollectionViewCell: UICollectionViewCell {

  private let locale = Locale.current
  static let identifier = "CurrencyCollectionViewCell"
  private let currencyCellView = CurrencyCellView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {
    contentView.backgroundColor = .blue
    currencyCellView.stackView.addArrangedSubview(currencyCellView.currencyNameLabel)
    currencyCellView.stackView.addArrangedSubview(currencyCellView.currencyCodeLabel)
    contentView.addSubViews([currencyCellView.stackView, currencyCellView.currencyRateLabel])

    let safeArea = contentView.layoutMarginsGuide
    currencyCellView.stackView.pinToLayoutGuide(layoutGuide: safeArea, constant: 1.0)
    NSLayoutConstraint.deactivate([currencyCellView.stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -1.0)])
    currencyCellView.stackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5).isActive = true
    currencyCellView.currencyRateLabel.leadingAnchor.constraint(equalTo: currencyCellView.stackView.trailingAnchor, constant: 1.0).isActive = true
    currencyCellView.currencyRateLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
  }

  func update(with key: String, value: String) {
    currencyCellView.currencyCodeLabel.text = key
    currencyCellView.currencyRateLabel.text = value
    currencyCellView.currencyNameLabel.text = locale.localizedString(forCurrencyCode: key)
  }
}
