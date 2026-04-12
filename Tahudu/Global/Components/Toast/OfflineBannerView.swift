import SwiftUI

struct OfflineBannerView: View {
  let isShowing: Bool
  
  var body: some View {
    if isShowing {
      VStack {
        Spacer()
        
        HStack(spacing: 8) {
          Image(sfSymbol: .wifiSlash)
          Text("No internet connection")
        }
        .font(.subheadline)
        .fontWeight(.medium)
        .foregroundColor(.white)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color.red)
        .cornerRadius(8)
        .padding(.bottom, 75)
        .padding(.horizontal, 20)
        .transition(.move(edge: .bottom))
      }
    }
  }
}

extension View {
  func offlineBanner(isShowing: Bool) -> some View {
    ZStack {
      self
      OfflineBannerView(isShowing: isShowing)
    }
    .animation(.easeInOut, value: isShowing)
  }
}
