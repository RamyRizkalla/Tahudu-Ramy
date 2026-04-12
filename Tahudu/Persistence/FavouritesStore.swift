import CoreData

protocol FavouritesStoreProtocol {
  func fetchFavouriteIDs() throws -> Set<String>
  func addFavourite(id: String) throws
  func removeFavourite(id: String) throws
  func isFavourite(id: String) throws -> Bool
  func toggleFavourite(id: String) throws -> Bool
}

final class FavouritesStore: FavouritesStoreProtocol {
  private let context: NSManagedObjectContext
  
  init(context: NSManagedObjectContext = PersistenceController.shared.viewContext) {
    self.context = context
  }
  
  func fetchFavouriteIDs() throws -> Set<String> {
    let request: NSFetchRequest<FavouriteProperty> = FavouriteProperty.fetchRequest()
    let results = try context.fetch(request)
    return Set(results.compactMap { $0.propertyId })
  }
  
  func addFavourite(id: String) throws {
    let favourite = FavouriteProperty(context: context)
    favourite.propertyId = id
    try context.save()
  }
  
  func removeFavourite(id: String) throws {
    let predicate = #Predicate<FavouriteProperty> { property in
      property.propertyId == id
    }
    let request: NSFetchRequest<FavouriteProperty> = FavouriteProperty.fetchRequest()
    request.predicate = NSPredicate(predicate)
    let results = try context.fetch(request)
    for object in results {
      context.delete(object)
    }
    try context.save()
  }
  
  func isFavourite(id: String) throws -> Bool {
    let predicate = #Predicate<FavouriteProperty> { property in
      property.propertyId == id
    }

    let request: NSFetchRequest<FavouriteProperty> = FavouriteProperty.fetchRequest()
    request.predicate = NSPredicate(predicate)
    let count = try context.count(for: request)
    return count > 0
  }
  
  /// Toggles the favourite state and returns the new state.
  func toggleFavourite(id: String) throws -> Bool {
    if try isFavourite(id: id) {
      try removeFavourite(id: id)
      return false
    } else {
      try addFavourite(id: id)
      return true
    }
  }
}
