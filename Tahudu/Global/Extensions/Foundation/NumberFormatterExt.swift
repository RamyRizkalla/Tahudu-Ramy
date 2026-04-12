import Foundation

extension NumberFormatter {
  static func currencyFormatter(for currencyCode: String) -> NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = currencyCode
    formatter.maximumFractionDigits = 0
    return formatter
  }
}
