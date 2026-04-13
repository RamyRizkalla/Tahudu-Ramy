import SwiftUI

enum PropertyTag: Hashable {
  case verified
  case newConstruction
  case liveViewing
  case other(String)
  
  init(rawValue: String) {
    switch rawValue.lowercased() {
    case "verified":
      self = .verified
    case "new_construction":
      self = .newConstruction
    case "live_viewing":
      self = .liveViewing
    default:
      self = .other(rawValue)
    }
  }
  
  var displayLabel: String {
    switch self {
    case .verified:
      return "Verified"
    case .newConstruction:
      return "New Construction"
    case .liveViewing:
      return "Live Viewing"
    case .other(let value):
      return value.capitalizedFromSnakeCase
    }
  }
  
  var badgeColor: Color {
    switch self {
    case .verified:
      return .green
    default:
      return .darkBlue.opacity(0.3)
    }
  }
  
  var foregroundColor: Color {
    switch self {
    case .verified:
      return .white
    default:
      return .white
    }
  }
}
