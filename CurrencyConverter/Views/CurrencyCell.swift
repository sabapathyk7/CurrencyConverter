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
    vstackView.distribution = .fillProportionally
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

    stackView.anchor(top: self.margingTop, leading: self.marginLeading,
                     bottom: self.marginBottom, trailing: nil,
                     inset: UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 0))
    stackView.anchorDimension(width: self.marginWidth, height: nil, inset: UIEdgeInsets(top: 0, left: 0.7, bottom: 0, right: 0.0))
    currencyRateLabel.anchorCenter(centerX: nil, centerY: self.marginCenterY)
    currencyRateLabel.anchor(top: nil, leading: stackView.marginTrailing,
                             bottom: nil, trailing: nil,
                             inset: UIEdgeInsets(top: 0, left: 1.0, bottom: 0, right: 0))
  }
  fileprivate func update(with model: TableViewData) {
    currencyCodeLabel.text = model.currencyName
    currencyRateLabel.text = String(format: "%f", model.currencyValue)
    currencyNameLabel.text = locale.localizedString(forCurrencyCode: model.currencyName)
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
  func update(with model: TableViewData) {
    currencyCellView.update(with: model)
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
  func update(with model: TableViewData) {
    currencyCellView.update(with: model)
  }
}
