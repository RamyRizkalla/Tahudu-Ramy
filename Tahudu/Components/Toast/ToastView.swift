import SwiftUI

struct ToastView: View {
  let message: String
  @Binding var isShowing: Bool
  
  var body: some View {
    if isShowing {
      VStack {
        Spacer()
        
        Text(message)
          .font(.subheadline)
          .foregroundColor(.white)
          .padding(.horizontal, 20)
          .padding(.vertical, 12)
          .background(Color.black.opacity(0.8))
          .cornerRadius(25)
          .shadow(radius: 4)
          .padding(.bottom, 50)
          .transition(.opacity.combined(with: .move(edge: .bottom)))
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          withAnimation {
            isShowing = false
          }
        }
      }
    }
  }
}

extension View {
  func toast(message: String, isShowing: Binding<Bool>) -> some View {
    ZStack {
      self
      ToastView(message: message, isShowing: isShowing)
    }
  }
}
