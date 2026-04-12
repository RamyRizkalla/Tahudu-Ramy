import SwiftUI

struct SearchView: View {
  @State private var searchText = ""
  @StateObject private var viewModel = SearchViewModel()
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
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
          EmptyStateView(
            symbol: .exclamationmarkCircle,
            text: "Something went wrong",
            subtext: errorMessage
          )
        } else if viewModel.displayedProperties.isEmpty {
          EmptyStateView(
            symbol: viewModel.showFavouritesOnly ? .star : .magnifyingglass,
            text: viewModel.showFavouritesOnly ? "No favourite properties yet" : "No properties found",
            subtext: viewModel.showFavouritesOnly ? "Tap the heart icon to add properties to your favourites" : "Try adjusting your search or filters"
          )
        } else {
          ScrollView {
            LazyVStack(spacing: 0) {
              ForEach(viewModel.displayedProperties) { property in
                CardView(property: property) {
                  viewModel.send(.toggleFavourite(property: property))
                } onContactTap: {
                  viewModel.send(.contactTapped)
                }
              }
            }
            .padding(.vertical, 8)
          }
          .refreshable {
            viewModel.send(.fetchProperties(query: searchText))
          }
        }
      }
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button {
            viewModel.send(.filterTapped)
          } label: {
            Image(sfSymbol: .sliderHorizontal3)
              .foregroundColor(.gray)
          }
        }

        ToolbarItem(placement: .topBarLeading) {
          Button {
            viewModel.send(.sortTapped)
          } label: {
            Image(sfSymbol: .arrowUpArrowDown)
              .foregroundColor(.gray)
          }
        }

        ToolbarItem(placement: .topBarTrailing) {
          Button {
            viewModel.send(.toggleFavouritesFilter)
          } label: {
            HStack(spacing: 4) {
              Image(sfSymbol: viewModel.showFavouritesOnly ? .heartfill : .heart)
                .foregroundColor(viewModel.showFavouritesOnly ? .darkBlue : .gray)
              Text("Favourites")
                .font(.subheadline)
                .foregroundColor(viewModel.showFavouritesOnly ? .darkBlue : .gray)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
          }
        }
      }
    }
    .task {
      viewModel.send(.fetchProperties(query: searchText))
    }
    .toast(message: viewModel.toastMessage, isShowing: $viewModel.showToast)
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView()
  }
}
