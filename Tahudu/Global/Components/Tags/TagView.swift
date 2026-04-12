import SwiftUI

struct TagView: View {
  let title: String
  let foregroundColor: Color
  let background: Color

  var body: some View {
    Text(title)
      .font(.tag)
      .fontWeight(.bold)
      .foregroundColor(foregroundColor)
      .padding(.horizontal, 8)
      .padding(.vertical, 4)
      .background(background)
      .cornerRadius(4)
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  VStack {
    TagView(
      title: "Twin House",
      foregroundColor: .white,
      background: .blue
    )
    
    TagView(
      title: "Apartment",
      foregroundColor: .white,
      background: .gray
    )
  }
}
