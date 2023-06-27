//
//  CurrencyDataSource.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 27/06/23.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
}

class CurrencyDataSource: GenericDataSource<Currency>, UITableViewDataSource{

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
    return cell
  }
}
