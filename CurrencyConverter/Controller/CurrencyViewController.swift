//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import UIKit

class CurrencyViewController: UIViewController {

  private let currencyViewModel:CurrencyViewModel = CurrencyViewModel()
  private var currencyTableView: UITableView = UITableView()
  private var currencyData:CurrencyData?

  override func viewDidLoad() {
    super.viewDidLoad()

    let displayWidth: CGFloat = self.view.frame.width
    let displayHeight: CGFloat = self.view.frame.height
    currencyTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
    currencyTableView.register(CurrencyCell.self, forCellReuseIdentifier: "CurrencyCell")
    self.view.addSubview(currencyTableView)
    currencyTableView.delegate = self
    currencyTableView.dataSource = self
    currencyViewModel.callFetchCurrencyData { currencyData in
      self.currencyData = currencyData
      DispatchQueue.main.async {
        self.currencyTableView.reloadData()
      }
    }
  }
}

extension CurrencyViewController: UITableViewDelegate {

}

extension CurrencyViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currencyData?.rates.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyCell else {
      return UITableViewCell()
    }
    guard let currencies = currencyData?.rates else {
      return UITableViewCell()
    }
    let key = Array(currencies)[indexPath.row].key
    let value = String(format: "%f", Array(currencies)[indexPath.row].value)
    cell.update(with: key, value: value)
    return cell
  }

}
