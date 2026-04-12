import SwiftUI
import UIKit

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
}

public extension Image {
  init(sfSymbol: SFSymbol) {
    self.init(systemName: sfSymbol.rawValue)
  }
}

public extension UIImage {
  convenience init?(sfSymbol: SFSymbol, withConfiguration configuration: Configuration) {
    self.init(systemName: sfSymbol.rawValue, withConfiguration: configuration)
  }
}
