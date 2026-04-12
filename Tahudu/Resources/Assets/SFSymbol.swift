import SwiftUI
import UIKit

/// A type-safe enum wrapper for SF Symbols used throughout the application.
/// Each case corresponds to a specific SF Symbol name from Apple's SF Symbols library.
public enum SFSymbol: String {
  case heart = "heart"
  case heartfill = "heart.fill"
  case sliderHorizontal3 = "slider.horizontal.3"
  case arrowUpArrowDown = "arrow.up.arrow.down"
  case star = "star"
  case starFill = "star.fill"
  case bedDouble = "bed.double"
  case phoneFill = "phone.fill"
  case deleteLeft = "delete.left"
  case deleteRight = "delete.right"
  case textformat = "textformat"
  case globe = "globe"
  case appBadge = "app.badge"
  case infoCircle = "info.circle"
  case textBubble = "text.bubble"
  case magnifyingglass = "magnifyingglass"
  case wifiSlash = "wifi.slash"
  case exclamationmarkCircle = "exclamationmark.circle"
}

public extension Image {
  /// Initializes an Image with an SF Symbol.
  /// - Parameter sfSymbol: The SFSymbol enum case to use for the image.
  init(sfSymbol: SFSymbol) {
    self.init(systemName: sfSymbol.rawValue)
  }
}

public extension UIImage {
  /// Initializes a UIImage with an SF Symbol and optional configuration.
  /// - Parameters:
  ///   - sfSymbol: The SFSymbol enum case to use for the image.
  ///   - configuration: The configuration to use for the symbol image (e.g., weight, scale).
  convenience init?(sfSymbol: SFSymbol, withConfiguration configuration: Configuration) {
    self.init(systemName: sfSymbol.rawValue, withConfiguration: configuration)
  }
}
