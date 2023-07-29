//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import UIKit

class CurrencyCell: UITableViewCell {

  static let identifier = "CurrencyCell"
  private lazy var stackView: UIStackView = {
    let vstackView = UIStackView()
    vstackView.axis = .vertical
//    vstackView.alignment = .center
    vstackView.distribution = .fill
//    vstackView.spacing = 10
    return vstackView
  }()

  private lazy var currencyNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .blue
    return label
  }()

  private lazy var currencyCodeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .blue
    return label
  }()

  private lazy var mainStackView: UIStackView = {
    let hstackView = UIStackView()
    hstackView.axis = .horizontal
//    hstackView.alignment = .center
    hstackView.distribution = .fill
//    hstackView.spacing = 10
    return hstackView
  }()

  private lazy var currencyRateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .blue
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

    mainStackView.addArrangedSubview(currencyRateLabel)
    mainStackView.addArrangedSubview(stackView)
    contentView.addSubview(stackView)
    contentView.addSubview(mainStackView)

    let safeArea = contentView.layoutMarginsGuide
    mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
    mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
    mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true

    currencyNameLabel.heightAnchor.constraint(equalToConstant: 140).isActive = true
    currencyNameLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
  }

  func update(with key: String, value: String) {
    currencyCodeLabel.text = key
    currencyRateLabel.text = value
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
