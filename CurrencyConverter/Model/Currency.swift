//
//  Currency.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import Foundation

// Active
// https://pastebin.com/raw/Nq1KvHjZ

 struct CurrencyData: Decodable {
  let success: Bool
  let timestamp: Int
  let base: String
  let date: String
  let rates: [String: Double]
 }

struct TableViewData: Identifiable {
  let id = UUID()
  var currencyName: String
  var currencyValue: Double
}
