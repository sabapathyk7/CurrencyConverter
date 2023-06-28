//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import UIKit

class CurrencyCell: UITableViewCell {

  lazy var stackView: UIStackView = {
    let vstackView = UIStackView()
    vstackView.axis = .vertical
    vstackView.alignment = .center
    vstackView.distribution = .fillEqually
    vstackView.spacing = 10
    return vstackView
  }()

  lazy var currencyNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  lazy var currencyCodeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()

  lazy var mainStackView: UIStackView = {
    let hstackView = UIStackView()
    hstackView.axis = .horizontal
    hstackView.alignment = .center
    hstackView.distribution = .fillEqually
    hstackView.spacing = 10
    return hstackView
  }()

  lazy var currencyRateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()


  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupUI(){
    stackView.addArrangedSubview(currencyNameLabel)
    stackView.addArrangedSubview(currencyCodeLabel)

    mainStackView.addArrangedSubview(currencyRateLabel)
    mainStackView.addArrangedSubview(stackView)
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
