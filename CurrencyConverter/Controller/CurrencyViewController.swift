//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import UIKit

class CurrencyViewController: UIViewController {

  private var currencyViewModel:CurrencyViewModel = CurrencyViewModel()
  private var dataSource: CurrencyDataSource<CurrencyCell,Currency>!
  private var currencyTableView: UITableView = UITableView()

  override func viewDidLoad() {
    super.viewDidLoad()

    let displayWidth: CGFloat = self.view.frame.width
    let displayHeight: CGFloat = self.view.frame.height
    currencyTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
    currencyTableView.register(CurrencyCell.self, forCellReuseIdentifier: "CurrencyCell")
    self.view.addSubview(currencyTableView)

    callViewModelForUIUpdate()

  }

  func callViewModelForUIUpdate() {
    self.currencyViewModel = CurrencyViewModel()
    self.currencyViewModel.bindCurrencyViewModelToController = {
      self.updateDataSource()
    }
  }

  func updateDataSource() {
    self.dataSource = CurrencyDataSource(cellIdentifier: "CurrencyCell", currencies: self.currencyViewModel.currencyData, configureCell: { cell, cvm in
      let currencyCell = cell as! CurrencyCell
      print(cvm.code)
      currencyCell.currencyCodeLabel.text = cvm.code
      currencyCell.currencyRateLabel.text = String(format: "%f", cvm.rate)
      let locale = Locale.current
      currencyCell.currencyNameLabel.text = locale.localizedString(forCurrencyCode: cvm.code )

    })
    DispatchQueue.main.async {
      self.currencyTableView.dataSource = self.dataSource
      self.currencyTableView.reloadData()
    }
  }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
