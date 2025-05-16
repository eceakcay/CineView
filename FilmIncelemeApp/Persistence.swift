import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

  @MainActor
  static let preview: PersistenceController = {
      let result = PersistenceController(inMemory: true)
      let viewContext = result.container.viewContext
      for i in 0..<3 {
          let newFavorite = FavoriteMovie(context: viewContext)
          newFavorite.id = Int32(i + 1)
          newFavorite.title = "Örnek Film \(i + 1)"
          newFavorite.overview = "Bu bir örnek filmdir."
          newFavorite.posterPath = i % 2 == 0 ? "/example\(i).jpg" : nil
          newFavorite.releaseDate = "2023-01-0\(i + 1)"
          newFavorite.timestamp = Date()
      }
      do {
          try viewContext.save()
      } catch {
          let nsError = error as NSError
          fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
      return result
  }()

  let container: NSPersistentContainer

  init(inMemory: Bool = false) {
      container = NSPersistentContainer(name: "FilmIncelemeApp")
      if inMemory {
          container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
      }
      container.loadPersistentStores { (storeDescription, error) in
          if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      }
      container.viewContext.automaticallyMergesChangesFromParent = true
  }

}
