//
//  CurrencyView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 27/06/23.
//

import UIKit

class CurrencyView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  // Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  // Required Initializers
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  // Phases of displaying a view
  // Update Constraints
  // Update Layout
  // Layout Subviews
  override func layoutSubviews() {
    super.layoutSubviews()
  }

  override func updateConstraints() {
    super.updateConstraints()
  }

  override class var requiresConstraintBasedLayout: Bool {
    return true
  }
}
