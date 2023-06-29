//
//  Currency.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import Foundation

// Active
//https://pastebin.com/raw/Nq1KvHjZ

struct Currency: Decodable {
//  let success: Bool
//  let timestamp: Int
//  let base: String
//  let date: String
  let rates: [CurrencyData]
}

struct CurrencyData: Decodable{
    let code: String
    let rate: Int
}
