import SwiftUI

struct CarouselView: View {
  let images: [String]
  @State private var currentPage = 0
  
  var body: some View {
    TabView(selection: $currentPage) {
      ForEach(0..<images.count, id: \.self) { index in
        Image(images[index])
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()
          .tag(index)
      }
    }
    .tabViewStyle(.page(indexDisplayMode: .always))
    .frame(height: 280)
    .clipped()
  }
}

#Preview {
  CarouselView(
    images: ["FirstImage", "SecondImage", "FirstImage", "SecondImage", "FirstImage", "SecondImage", "FirstImage", "SecondImage", "FirstImage", "SecondImage", "FirstImage", "SecondImage","FirstImage", "SecondImage" ,"FirstImage", "SecondImage" ,"FirstImage", "SecondImage", "FirstImage", "SecondImage", "FirstImage", "SecondImage", "FirstImage", "SecondImage"]
  )
}
