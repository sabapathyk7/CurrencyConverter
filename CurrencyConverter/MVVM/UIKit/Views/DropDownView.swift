//
//  DropDownView.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 09/08/23.
//

import UIKit

protocol DropDownDelegate: AnyObject {
    func didSelect(_ index: Int)
}

class DropDownView: UIView {
    var dataSource: [String] = [] {
        didSet {
            updateDataSource()
        }
    }
    private var tableViewHeight: NSLayoutConstraint?
    private var buttonHeightConstraint: NSLayoutConstraint?
    private var buttonHeight: CGFloat = 40 {
        didSet {
            buttonHeightConstraint?.constant = buttonHeight
            updateDataSource()
        }
    }
    weak var delegate: DropDownDelegate?
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("EUR ⬇\u{FE0E}", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 10.0)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DropdownTableViewCell.self, forCellReuseIdentifier: "DropdownTableViewCell")
        tableView.isHidden = true
        return tableView
    }()
    private lazy var stackView: UIStackView = {
        let vStackView = UIStackView()
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        vStackView.alignment = .fill
        return vStackView
    }()
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func updateDataSource() {
        DispatchQueue.main.async {
            if self.dataSource.count >= 1 {
                self.tableViewHeight?.constant = 500
            } else {
                self.tableViewHeight?.constant = 500
            }
            self.tableView.reloadData()
        }
    }
    private func setupUI() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        tableViewHeight = tableView.marginHeight.constraint(equalToConstant: 0)
        tableViewHeight?.isActive = true
        stackView.pinToLayoutGuide(layoutGuide: self.marginGuide)
    }
    @objc private func buttonTapped() {
        tableView.isHidden.toggle()
    }
}

extension DropDownView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return buttonHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        button.setTitle(dataSource[indexPath.row] + "⬇\u{FE0E}", for: .normal)
        delegate?.didSelect(indexPath.row)
        tableView.isHidden = true
    }
}

extension DropDownView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownTableViewCell", for: indexPath) as? DropdownTableViewCell else {
            return UITableViewCell()
        }
        cell.setLabelText(dataSource[indexPath.row])
        return cell
    }
}
