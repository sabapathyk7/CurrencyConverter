//
//  RequestService.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 28/06/23.
//

//http://data.fixer.io/api/latest?access_key=b81d1c9164455d145db5025bad69d5c2

import Foundation

class RequestService {

    private let baseURL = "https://v6.exchangerate-api.com/v6/"
    private let accessKey = "c1a4fe51ecfcebb4ddda0835"
//  private let apiURL = URL(string: "https://v6.exchangerate-api.com/v6/c1a4fe51ecfcebb4ddda0835/latest/EUR")

//  let colonOnWrongSide :Int = 0
    func fetchCurrencyData(baseCurrency: String, completion: @escaping (CurrencyData) -> Void) {
        let apiURL = URL(string: baseURL + accessKey + "/latest/\(baseCurrency)")
    if let apiURL = apiURL {
      URLSession.shared.dataTask(with: URLRequest.init(url: apiURL)) { data, _, error in
        if let data = data {
          do {
              let json = try? JSONSerialization.jsonObject(with: data, options: [])
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
