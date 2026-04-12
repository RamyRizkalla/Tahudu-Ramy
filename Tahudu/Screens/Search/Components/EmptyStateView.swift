import SwiftUI

struct EmptyStateView: View {
  let symbol: SFSymbol
  let text: String
  let subtext: String?
  
  init(symbol: SFSymbol, text: String, subtext: String? = nil) {
    self.symbol = symbol
    self.text = text
    self.subtext = subtext
  }
  
  var body: some View {
    VStack(spacing: 12) {
      Image(sfSymbol: symbol)
        .font(.system(size: 48))
        .foregroundColor(.gray)
      Text(text)
        .font(.headline)
        .foregroundColor(.gray)
      if let subtext = subtext {
        Text(subtext)
          .font(.subheadline)
          .foregroundColor(.gray.opacity(0.7))
          .multilineTextAlignment(.center)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  VStack {
    EmptyStateView(
      symbol: .magnifyingglass,
      text: "No properties found",
      subtext: "Try adjusting your search or filters"
    )
    
    EmptyStateView(
      symbol: .star,
      text: "No favourite properties yet",
      subtext: "Tap the heart icon to add properties to your favourites"
    )
    
    EmptyStateView(
      symbol: .globe,
      text: "No items"
    )
  }
}
