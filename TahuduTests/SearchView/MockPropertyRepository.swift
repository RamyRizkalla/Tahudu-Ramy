import Foundation
@testable import Tahudu

final class MockPropertyRepository: PropertyRepositoryProtocol, @unchecked Sendable {
  var stubbedProperties: [Property] = []
  var stubbedToggleResult: Bool = true
  var fetchError: Error?
  var toggleError: Error?
  
  func fetchProperties() async throws -> [Property] {
    if let error = fetchError { throw error }
    return stubbedProperties
  }
  
  func toggleFavourite(for propertyID: String) throws -> Bool {
    if let error = toggleError { throw error }
    return stubbedToggleResult
  }
  
  func favouriteIDs() throws -> Set<String> {
    Set(stubbedProperties.filter(\.isFavorited).map(\.id))
  }
}
