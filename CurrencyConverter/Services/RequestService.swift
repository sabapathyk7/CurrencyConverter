//
//  RequestService.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 28/06/23.
//

import Foundation

class RequestService {

  private let apiURL = URL(string: "https://pastebin.com/raw/Nq1KvHjZ")!

  func fetchCurrencyData(completion: @escaping ([Currency]) -> ()){
    URLSession.shared.dataTask(with: URLRequest.init(url: apiURL)) { data, response, error in
      do {
        if let dictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject] {
          if let rates = dictionary["rates"] as? [String: Double] {
            let finalRates:[Currency] = rates.compactMap({Currency(code: $0.key, rate: $0.value)})
            completion(finalRates)
          }
        } else {
          completion([])
        }
      } catch {
        completion([])
      }
    }.resume()
  }
}
