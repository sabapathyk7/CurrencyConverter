//
//  CurrencyTCAService.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 27/08/23.
//

import Foundation
import Combine

// MARK: - Service Protocol
protocol CurrencyServiceProtocol {
  func getCurrencyData<T: Decodable>() -> AnyPublisher<T, NAError>
}

final class CurrencyService {
  let endpointURL = "https://pastebin.com/raw/Nq1KvHjZ"
  let jsonDecoder = JSONDecoder()
  private let session: URLSession

  init(session: URLSession) {
    self.session = session
  }
}

extension CurrencyService: CurrencyServiceProtocol {
  func getCurrencyData<T>() -> AnyPublisher<T, NAError> where T : Decodable {
    var request = URLRequest(url: URL(string: endpointURL)!)
    request.httpMethod = "GET"

    return session.dataTaskPublisher(for: request)
      .map(\.data)
      .decode(type: T.self, decoder: jsonDecoder)
      .mapError { e -> NAError in
        switch e {
        case is Swift.DecodingError:
          return .mapping
        default:
          return .generic
        }
      }
      .eraseToAnyPublisher()
  }
}

fileprivate struct Constants {
    static let badUrl = "Sorry, this URL is not valid"
    static let mapping = "Error raised, while mapping data"
    static let generic = "Sorry, try again later"
}

public enum NAError: Equatable {
    case badUrl
    case mapping
    case generic
}

extension NAError: Error {
    public var localizedDescription: String {
        switch self {
        case .badUrl:
            return Constants.badUrl
        case .mapping:
            return Constants.mapping
        case .generic:
            return Constants.generic
        }
    }
}
