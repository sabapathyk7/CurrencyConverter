//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

struct State: Equatable {
  var currencyName: String
  var currencyValue: Double
}
enum Action: Equatable {
  case showCurrencyName
  case showCurrencyValue
}
