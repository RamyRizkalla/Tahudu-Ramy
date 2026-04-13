import Foundation

@MainActor
class SearchViewModel: ObservableObject {
  enum Action {
    case fetchProperties(query: String)
    case searchSubmitted(query: String)
    case searchCleared
    case toggleFavourite(property: Property)
    case toggleFavouritesFilter
    case filterTapped
    case sortTapped
    case contactTapped(contactType: ContactType)
    case clearError
  }
  
  @Published var properties: [Property] = []
  @Published var isLoading: Bool = false
  @Published var errorMessage: String?
  @Published var showFavouritesOnly: Bool = false
  @Published var toastMessage: String = ""
  @Published var showToast: Bool = false
  @Published var searchQuery: String = ""

  var displayedProperties: [Property] {
    let filtered = showFavouritesOnly ? properties.filter { $0.isFavorited } : properties
    guard !searchQuery.isEmpty else { return filtered }
    return filtered.filter { $0.matches(searchQuery) }
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
    case .searchSubmitted(let query):
      searchQuery = query
    case .searchCleared:
      searchQuery = ""
    case .toggleFavourite(let property):
      Task {
        await toggleFavourite(for: property)
      }
    case .toggleFavouritesFilter:
      toggleFavouritesFilter()
    case .filterTapped:
      filterTapped()
    case .sortTapped:
      sortTapped()
    case .contactTapped(let contactType):
      contactTapped(contactType: contactType)
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

  private func toggleFavourite(for property: Property) async {
    do {
      let newState = try await repository.toggleFavourite(for: property.id)
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

  private func filterTapped() {
    let text = "Filter tapped"
    print(text)
    toastMessage = text
  }

  private func sortTapped() {
    let text = "Sort tapped"
    print(text)
    toastMessage = text
  }

  private func contactTapped(contactType: ContactType) {
    let text = "Contact tapped: \(contactType.rawValue)"
    print(text)
    toastMessage = text
  }
}
