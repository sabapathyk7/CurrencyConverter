//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import UIKit

class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let dictionary = self.currencyViewModel.currencyData?.rates as? [String: Double]  {
      return dictionary.count
    }
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
    let currencies = self.currencyViewModel.currencyData?.rates
    let data = currencies?.compactMap{$0}
    if let data = data {
      let (key, value) = data[indexPath.row]
      cell.currencyCodeLabel.text = key
      cell.currencyRateLabel.text = String(format: "%p", value)
    }
    return cell
  }


  private var currencyViewModel:CurrencyViewModel = CurrencyViewModel()
//  private var dataSource: CurrencyDataSource<CurrencyCell,CurrencyData>!
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
    callViewModelForUIUpdate()
  }

  func callViewModelForUIUpdate() {
    self.currencyViewModel = CurrencyViewModel()
    self.currencyViewModel.bindCurrencyViewModelToController = {
//      self.updateDataSource()
      DispatchQueue.main.async {
            self.currencyTableView.dataSource = self
            self.currencyTableView.reloadData()
          }

    }
  }

//  func updateDataSource() {
//
//    dataSource = CurrencyDataSource(cellIdentifier: "CurrencyCell", currencies: currencyViewModel.currencyData, configureCell: { cell, cvm in
//      let currencyCell = cell as! CurrencyCell
//      print(cvm.code)
//      currencyCell.currencyCodeLabel.text = cvm.code
//      currencyCell.currencyRateLabel.text = String(format: "%f", cvm.rate)
//      let locale = Locale.current
//      currencyCell.currencyNameLabel.text = locale.localizedString(forCurrencyCode: cvm.code )
//
//    })
//    DispatchQueue.main.async {
//      self.currencyTableView.dataSource = self.dataSource
//      self.currencyTableView.reloadData()
//    }
//  }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
