import CoreData

struct PersistenceController {
  static let shared = PersistenceController()
  
  private let container: NSPersistentContainer
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Tahudu")
    
    if inMemory {
      container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }
    
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    container.viewContext.automaticallyMergesChangesFromParent = true
  }
}

extension PersistenceController {
  var viewContext: NSManagedObjectContext {
    self.container.viewContext
  }
}
