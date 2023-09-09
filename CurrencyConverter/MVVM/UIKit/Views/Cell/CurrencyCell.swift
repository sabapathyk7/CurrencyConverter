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
        vstackView.distribution = .fill
        return vstackView
    }()
    private lazy var currencyNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    private lazy var currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    private lazy var currencyRateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setupUI() {
        stackView.addArrangedSubviews([currencyNameLabel, currencyCodeLabel])
        self.addSubViews([stackView, currencyRateLabel])
        stackView.anchor(top: self.marginTop,
                         leading: self.marginLeading,
                         bottom: self.marginBottom,
                         inset: UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 0))
        stackView.anchorDimension(width: self.marginWidth,
                                  inset: UIEdgeInsets(top: 0, left: 0.7, bottom: 0, right: 0.0))
        currencyRateLabel.anchorCenter(centerY: self.marginCenterY)
        currencyRateLabel.anchor(leading: stackView.marginTrailing,
                                 inset: UIEdgeInsets(top: 0, left: 1.0, bottom: 0, right: 0))
    }
    fileprivate func update(with model: TableViewData) {
        currencyCodeLabel.text = model.currencyCode + model.currencyCode.dropLast().description.countryFlag()
        currencyRateLabel.text = String(format: "%.2f", model.currencyValue.rounded(toPlaces: 2))
        currencyNameLabel.text = model.currencyName
    }
}
class CurrencyCell: UITableViewCell {
    static let identifier = "CurrencyCell"
    private var currencyCellView = CurrencyCellView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.currencyCellView = CurrencyCellView()
        contentView.addSubview(currencyCellView)
        currencyCellView.pinToLayoutGuide(layoutGuide: contentView.layoutMarginsGuide)
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
        currencyCellView.pinToLayoutGuide(layoutGuide: contentView.layoutMarginsGuide)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    func update(with model: TableViewData) {
        currencyCellView.update(with: model)
    }
}
