//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import UIKit

class CurrencyCell: UITableViewCell {

  private let locale = Locale.current
  static let identifier = "CurrencyCell"
  private lazy var stackView: UIStackView = {
    let vstackView = UIStackView()

    vstackView.axis = .vertical
//    vstackView.alignment = .center
    vstackView.distribution = .fill
//    vstackView.spacing = 10
    vstackView.backgroundColor = .red
    return vstackView
  }()

  private lazy var currencyNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .left
    label.textColor = .black
//    label.setContentHuggingPriority(.required, for: .horizontal)
//    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    return label
  }()

  private lazy var currencyCodeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .left
    label.textColor = .black
//    label.setContentHuggingPriority(.required, for: .horizontal)
//    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    return label
  }()
  private lazy var currencyRateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .blue
    label.backgroundColor = .gray
//    label.setContentHuggingPriority(.required, for: .horizontal)
//    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {
    stackView.addArrangedSubview(currencyNameLabel)
    stackView.addArrangedSubview(currencyCodeLabel)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubViews([stackView, currencyRateLabel])

    let safeArea = contentView.layoutMarginsGuide
    stackView.pinToLayoutGuide(layoutGuide: safeArea, constant: 1.0)
    NSLayoutConstraint.deactivate([stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -1.0)])
//    NSLayoutConstraint.activate([
//      stackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.7),
//      stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
//      stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
//      stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 1.0)
//    ])
    stackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.7).isActive = true

    currencyRateLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 1.0).isActive = true
    currencyRateLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
  }

  func update(with key: String, value: String) {
    currencyCodeLabel.text = key
    currencyRateLabel.text = value
    currencyNameLabel.text = locale.localizedString(forCurrencyCode: key)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
}
