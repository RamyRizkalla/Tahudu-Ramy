import Foundation
import Testing
@testable import Tahudu

// MARK: - Helpers

private enum TestError: Error, LocalizedError {
  case generic
  var errorDescription: String? { "Something went wrong" }
}

// MARK: - Tests

@Suite("SearchViewModel Tests")
@MainActor
struct SearchViewModelTests {
  
  // MARK: fetchProperties
  
  @Test("fetchProperties populates properties on success")
  func fetchPropertiesSuccess() async {
    let mock = MockPropertyRepository()
    mock.stubbedProperties = Property.samples
    let vm = SearchViewModel(repository: mock)
    
    vm.send(.fetchProperties(query: ""))
    // Allow the internal Task to complete
    try? await Task.sleep(nanoseconds: 100_000_000)
    
    #expect(vm.properties.count == 2)
    #expect(vm.isLoading == false)
    #expect(vm.errorMessage == nil)
  }
  
  @Test("fetchProperties sets errorMessage on failure")
  func fetchPropertiesFailure() async {
    let mock = MockPropertyRepository()
    mock.fetchError = TestError.generic
    let vm = SearchViewModel(repository: mock)
    
    vm.send(.fetchProperties(query: ""))
    try? await Task.sleep(nanoseconds: 100_000_000)
    
    #expect(vm.properties.isEmpty)
    #expect(vm.errorMessage != nil)
    #expect(vm.isLoading == false)
  }
  
  // MARK: toggleFavourite
  
  @Test("toggleFavourite updates the correct property")
  func toggleFavouriteSuccess() async {
    let mock = MockPropertyRepository()
    mock.stubbedProperties = Property.samples
    mock.stubbedToggleResult = true
    let vm = SearchViewModel(repository: mock)
    
    // Pre-populate properties
    vm.send(.fetchProperties(query: ""))
    try? await Task.sleep(nanoseconds: 100_000_000)
    
    let target = vm.properties[0]
    #expect(target.isFavorited == false)
    
    vm.send(.toggleFavourite(property: target))
    
    #expect(vm.properties[0].isFavorited == true)
    #expect(vm.errorMessage == nil)
  }
  
  @Test("toggleFavourite sets errorMessage when repository throws")
  func toggleFavouriteFailure() async {
    let mock = MockPropertyRepository()
    mock.stubbedProperties = Property.samples
    let vm = SearchViewModel(repository: mock)
    
    vm.send(.fetchProperties(query: ""))
    try? await Task.sleep(nanoseconds: 100_000_000)
    
    mock.toggleError = TestError.generic
    let target = vm.properties[0]
    vm.send(.toggleFavourite(property: target))
    
    #expect(vm.errorMessage != nil)
    #expect(vm.properties[0].isFavorited == false)
  }
  
  // MARK: toggleFavouritesFilter
  
  @Test("toggleFavouritesFilter flips showFavouritesOnly")
  func toggleFavouritesFilter() {
    let vm = SearchViewModel(repository: MockPropertyRepository())
    
    #expect(vm.showFavouritesOnly == false)
    vm.send(.toggleFavouritesFilter)
    #expect(vm.showFavouritesOnly == true)
    vm.send(.toggleFavouritesFilter)
    #expect(vm.showFavouritesOnly == false)
  }
  
  // MARK: displayedProperties
  
  @Test("displayedProperties returns only favourited items when filter is on")
  func displayedPropertiesFiltered() async {
    let mock = MockPropertyRepository()
    mock.stubbedProperties = Property.samples
    let vm = SearchViewModel(repository: mock)
    
    vm.send(.fetchProperties(query: ""))
    try? await Task.sleep(nanoseconds: 100_000_000)
    
    vm.send(.toggleFavouritesFilter)
    
    #expect(vm.displayedProperties.count == 1)
    #expect(vm.displayedProperties.first?.id == "2")
  }
  
  @Test("displayedProperties returns all items when filter is off")
  func displayedPropertiesUnfiltered() async {
    let mock = MockPropertyRepository()
    mock.stubbedProperties = Property.samples
    let vm = SearchViewModel(repository: mock)
    
    vm.send(.fetchProperties(query: ""))
    try? await Task.sleep(nanoseconds: 100_000_000)
    
    #expect(vm.showFavouritesOnly == false)
    #expect(vm.displayedProperties.count == 2)
  }
  
  // MARK: clearError
  
  @Test("clearError resets errorMessage to nil")
  func clearError() async {
    let mock = MockPropertyRepository()
    mock.fetchError = TestError.generic
    let vm = SearchViewModel(repository: mock)
    
    vm.send(.fetchProperties(query: ""))
    try? await Task.sleep(nanoseconds: 100_000_000)
    #expect(vm.errorMessage != nil)
    
    vm.send(.clearError)
    #expect(vm.errorMessage == nil)
  }
}

private extension Property {
  static var samples: [Property] {
    [
      Property(
        id: "1",
        images: [],
        isVerified: true,
        isFavorited: false,
        type: "Apartment",
        tags: [],
        price: 100,
        currency: "AED",
        bedrooms: "Studio",
        publishedDate: Date(),
        contactTypes: [.phone]
      ),
      Property(
        id: "2",
        images: [],
        isVerified: false,
        isFavorited: true,
        type: "Villa",
        tags: [],
        price: 200,
        currency: "AED",
        bedrooms: "2 Bedrooms",
        publishedDate: Date(),
        contactTypes: [.email]
      )
    ]
  }
}
