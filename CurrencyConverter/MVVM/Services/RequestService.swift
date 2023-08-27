//
//  RequestService.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 28/06/23.
//

import Foundation

class RequestService {

  private let apiURL = URL(string: "https://pastebin.com/raw/Nq1KvHjZ")

//  let colonOnWrongSide :Int = 0
  func fetchCurrencyData(completion: @escaping (CurrencyData) -> Void) {
    if let apiURL = apiURL {
      URLSession.shared.dataTask(with: URLRequest.init(url: apiURL)) { data, _, error in
        if let data = data {
          do {
            let currencyData = try JSONDecoder().decode(CurrencyData.self, from: data)
            completion(currencyData)
          } catch let error {
            print(error)
          }
        }
      }.resume()
    }
  }
}
