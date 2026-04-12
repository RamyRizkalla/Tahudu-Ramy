import SwiftUI

struct SearchView: View {
  @State private var searchText = ""
  @StateObject private var viewModel = SearchViewModel()
  @State private var showToast = false
  @State private var toastMessage = ""
  
  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        HStack(spacing: 12) {
          Button(action: {
            print("Tapped filter button")
            toastMessage = "Filter tapped"
            showToast = true
          }) {
            Image(sfSymbol: .sliderHorizontal3)
              .foregroundColor(.gray)
          }
          
          Button(action: {
            print("Tapped sort button")
            toastMessage = "Sort tapped"
            showToast = true
          }) {
            Image(sfSymbol: .arrowUpArrowDown)
              .foregroundColor(.gray)
          }
          
          Spacer()
          
          Button(action: {
            viewModel.send(.toggleFavouritesFilter)
          }) {
            Image(sfSymbol: viewModel.showFavouritesOnly ? .starFill : .star)
              .foregroundColor(viewModel.showFavouritesOnly ? .yellow : .gray)
          }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        
        ClearableTextField(
          label: "City, area or building",
          symbol: .magnifyingglass,
          text: $searchText
        )
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        
        if viewModel.isLoading {
          ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else if let errorMessage = viewModel.errorMessage {
          VStack {
            Text("Error: \(errorMessage)")
              .foregroundColor(.red)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else {
          ScrollView {
            LazyVStack(spacing: 0) {
              ForEach(viewModel.displayedProperties) { property in
                CardView(property: property) {
                  viewModel.send(.toggleFavourite(property: property))
                } onContactTap: {
                  print("Tapped contact button")
                  toastMessage = "Contact tapped"
                  showToast = true
                }
              }
            }
            .padding(.vertical, 8)
          }
        }
      }
    }
    .task {
      viewModel.send(.fetchProperties(query: searchText))
    }
    .toast(message: toastMessage, isShowing: $showToast)
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView()
  }
}
