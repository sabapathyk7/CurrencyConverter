//
//  RequestService.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 28/06/23.
//

import Foundation

class RequestService {

  private let apiURL = URL(string: "https://api.fixer.io/latest?base=GBP")!

  func fetchCurrencyData(completion: @escaping (Currency) -> ()){
    URLSession.shared.dataTask(with: URLRequest.init(url: apiURL)) { data, response, error in
      if let data = data {
        let jsonDecoder = JSONDecoder()
        let currencyData = try! jsonDecoder.decode(Currency.self, from: data)
        completion(currencyData)
      } else {
        print("error")
      }
    }.resume()
  }

}
