

import CoreData

 class FavoriteService {
     private let context: NSManagedObjectContext
     
     init(context: NSManagedObjectContext) {
         self.context = context
     }
     
     //Movie nesnesini FavoriteMovie’a çevirir ve Core Data’ya kaydeder.
     func addFavorite(movie: Movie) throws {
         let favorite = FavoriteMovie(context: context)
         favorite.id = Int32(movie.id)
         favorite.title = movie.title
         favorite.overview = movie.overview
         favorite.posterPath = movie.posterPath
         favorite.releaseDate = movie.releaseDate
         favorite.timestamp = Date()
         try context.save()
         print("Favori eklendi: \(movie.title)")
     }
     
     func removeFavorite(movieId: Int) throws {
         let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
         request.predicate = NSPredicate(format: "id == %d", movieId)
         let favorites = try context.fetch(request)
         for favorite in favorites {
             context.delete(favorite)
         }
         try context.save()
         print("Favori silindi: \(movieId)")
     }
     
     //Tüm favorileri çeker, timestamp’e göre sıralar
     func fetchFavorites() throws -> [FavoriteMovie] {
         let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
         request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
         let favorites = try context.fetch(request)
         print("Çekilen favoriler: \(favorites.count)")
         return favorites
     }
     
     //Bir filmin favorilerde olup olmadığını kontrol eder.
     func isFavorite(movieId: Int) throws -> Bool {
         let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
         request.predicate = NSPredicate(format: "id == %d", movieId)
         let count = try context.count(for: request)
         return count > 0
     }
 }
