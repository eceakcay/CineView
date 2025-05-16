import Foundation
import CoreData

@MainActor
class FavoriteViewModel: ObservableObject {
    @Published var isFavorite: Bool = false
    private let service: FavoriteService

  init(context: NSManagedObjectContext) {
      self.service = FavoriteService(context: context)
  }
  
  func addFavorite(movie: Movie) throws {
      try service.addFavorite(movie: movie)
      isFavorite = true
      print("Favori eklendi: \(movie.title)") // Hata ayıklama
  }
  
  func removeFavorite(movieId: Int) throws {
      try service.removeFavorite(movieId: movieId)
      isFavorite = false
      print("Favori silindi: \(movieId)") // Hata ayıklama
  }
  
  func checkFavorite(movieId: Int) {
      do {
          isFavorite = try service.isFavorite(movieId: movieId)
          print("Favori durumu: \(isFavorite) for movieId: \(movieId)") // Hata ayıklama
      } catch {
          print("Favori durumu kontrol edilemedi: \(error)")
      }
  }
  
  func isFavorite(movieId: Int) throws -> Bool {
      return try service.isFavorite(movieId: movieId)
  }

}
