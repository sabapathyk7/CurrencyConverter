//
//  DropdownTableViewCell.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 09/08/23.
//

import UIKit

class DropdownTableViewCell: UITableViewCell {

  static let identifier = "DropdownTableViewCell"
  lazy var label: UILabel = {
    let label = UILabel()
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  private func setup() {
    contentView.addSubview(label)
    label.pinToLayoutGuide(layoutGuide: contentView.marginGuide, constant: 0)
  }
  func setLabelText(_ text: String) {
    label.text = text
  }
}