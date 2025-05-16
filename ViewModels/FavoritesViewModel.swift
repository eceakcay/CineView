//
//  FavoritesViewModel.swift
//  FilmIncelemeApp
//
//  Created by Ece Akcay on 8.05.2025.
//

import Foundation
import CoreData

//FavoritesView’da favori filmler listesini yönetir.
 @MainActor
 class FavoritesViewModel: ObservableObject {
     @Published var favorites: [FavoriteMovie] = []
     private let service: FavoriteService
     
     init(context: NSManagedObjectContext) {
         self.service = FavoriteService(context: context)
     }
     
     func fetchFavorites() async {
         do {
             favorites = try service.fetchFavorites()
             print("Favoriler yüklendi: \(favorites.count) adet")
             print("Çekilen favoriler: \(favorites.map { $0.title })")
         } catch {
             print("Favoriler yüklenemedi: \(error)")
         }
     }
 }
