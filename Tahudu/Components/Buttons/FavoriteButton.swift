import SwiftUI

struct FavoriteButton: View {
  let isFavorited: Bool
  let onToggle: () -> Void
  
  var body: some View {
    Button {
      onToggle()
    } label: {
      Image(sfSymbol: isFavorited ? .heartfill : .heart)
        .symbolEffect(.bounce, value: isFavorited)
        .foregroundColor(isFavorited ? .red : .white)
        .font(.title2)
        .padding(12)
    }
    .background(Color.black.opacity(0.3))
    .clipShape(Circle())
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  @Previewable @State var isFavorited: Bool = false
  
  FavoriteButton(isFavorited: isFavorited) {
    isFavorited.toggle()
  }
}
