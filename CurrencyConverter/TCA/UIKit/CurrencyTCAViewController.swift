//
//  CurrencyTCAViewController.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 23/08/23.
//

import UIKit

final class CurrencyTCAViewController: UIViewController {

  private lazy var textField: UITextField = {
    let textField = textField
    textField.borderStyle = .roundedRect
    textField.tintColor = .blue
    return textField
  }()

  private lazy var tableView: UITableView = {
    let tableView = tableView
    return tableView
  }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
