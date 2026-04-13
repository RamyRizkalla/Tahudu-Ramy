import Foundation

protocol PropertyRepositoryProtocol {
  func fetchProperties() async throws -> [Property]
  func toggleFavourite(for propertyID: String) async throws -> Bool
  func favouriteIDs() async throws -> Set<String>
}

final class PropertyRepository: PropertyRepositoryProtocol {
  private let provider: APIProvider<PropertyEndpoint>
  private let favouritesStore: FavouritesStoreProtocol
  
  init(
    provider: APIProvider<PropertyEndpoint> = APIProvider(stubBehavior: .never),
    favouritesStore: FavouritesStoreProtocol = FavouritesStore()
  ) {
    self.provider = provider
    self.favouritesStore = favouritesStore
  }
  
  func fetchProperties() async throws -> [Property] {
    let response: PropertiesResponse = try await provider.request(.listings)
    var properties = response.domainModel
    let favouriteIDs = try favouritesStore.fetchFavouriteIDs()
    
    for index in properties.indices {
      properties[index].isFavorited = favouriteIDs.contains(properties[index].id)
      // Map API image names (snake_case) to Asset image names (camelCase)
      properties[index].images = properties[index].images.map { mapImageNameToAsset($0) }
    }
    
    return properties
  }
  
  private func mapImageNameToAsset(_ name: String) -> String {
    switch name {
    case "first_image":
      return "FirstImage"
    case "second_image":
      return "SecondImage"
    default:
      return name.capitalized
    }
  }
  
  /// Toggles the favourite and returns the new state.
  func toggleFavourite(for propertyID: String) async throws -> Bool {
    try await Task {
      try favouritesStore.toggleFavourite(id: propertyID)
    }.value
  }
  
  func favouriteIDs() async throws -> Set<String> {
    try await Task.detached {
      try self.favouritesStore.fetchFavouriteIDs()
    }.value
  }
}
