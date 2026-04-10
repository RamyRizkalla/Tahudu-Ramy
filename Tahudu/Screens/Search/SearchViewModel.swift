import Foundation

@MainActor
class SearchViewModel: ObservableObject {
  enum Action {
    case fetchProperties(query: String)
    case toggleFavourite(property: Property)
    case toggleFavouritesFilter
    case clearError
  }
  
  @Published var properties: [Property] = []
  @Published var isLoading: Bool = false
  @Published var errorMessage: String?
  @Published var showFavouritesOnly: Bool = false

  var displayedProperties: [Property] {
    showFavouritesOnly ? properties.filter { $0.isFavorited } : properties
  }

  private let repository: PropertyRepositoryProtocol

  init(repository: PropertyRepositoryProtocol = PropertyRepository()) {
    self.repository = repository
  }
  
  func send(_ action: Action) {
    switch action {
    case .fetchProperties(let query):
      Task {
        await fetchProperties(query: query)
      }
    case .toggleFavourite(let property):
      toggleFavourite(for: property)
    case .toggleFavouritesFilter:
      toggleFavouritesFilter()
    case .clearError:
      errorMessage = nil
    }
  }
}

extension SearchViewModel {
  private func fetchProperties(query: String = "") async {
    isLoading = true
    errorMessage = nil

    do {
      self.properties = try await repository.fetchProperties()
    } catch {
      self.errorMessage = error.localizedDescription
    }

    isLoading = false
  }

  private func toggleFavourite(for property: Property) {
    do {
      let newState = try repository.toggleFavourite(for: property.id)
      if let index = properties.firstIndex(where: { $0.id == property.id }) {
        properties[index].isFavorited = newState
      }
    } catch {
      errorMessage = error.localizedDescription
    }
  }

  private func toggleFavouritesFilter() {
    showFavouritesOnly.toggle()
  }
}
