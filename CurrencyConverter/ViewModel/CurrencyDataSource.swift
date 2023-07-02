////
////  CurrencyDataSource.swift
////  CurrencyConverter
////
////  Created by kanagasabapathy on 27/06/23.
////
//
//import Foundation
//import UIKit
//
//class CurrencyDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {
//
//  private var cellIdentifier : String!
//  private var currencies : [T]!
//  var configureCell : (CELL, T) -> () = {_,_ in }
//
//  init(cellIdentifier: String, currencies: [T], configureCell: @escaping (UITableViewCell, T) -> Void) {
//    self.cellIdentifier = cellIdentifier
//    self.currencies = currencies
//    self.configureCell = configureCell
//  }
//  func numberOfSections(in tableView: UITableView) -> Int {
//    return 1
//  }
//
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return currencies.count
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CELL
//    let currency = self.currencies[indexPath.row]
//    self.configureCell(cell,currency)
//    return cell
//  }
//}
