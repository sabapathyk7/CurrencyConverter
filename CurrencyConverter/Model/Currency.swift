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

struct TableViewData: Identifiable, Hashable {
  let id = UUID()
  var base: String
  var currencyCode: String
  var currencyName: String
  var currencyValue: Double
  var currencySymbol: String
}

struct Currency {
  var code: String
  var symbol: String
}

/*
 1 euro is the base
 = 90.67 INR
 = 1.09 USD

 1 USD is the base
 =  if (1.09 USD = 90.67 INR) what is 1 USD = 83.18 INR
         90.67/1.09 * 1
 */
