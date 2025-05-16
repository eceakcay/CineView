//
//  ContentView.swift
//  FilmIncelemeApp
//
//  Created by Ece Akcay on 5.05.2025.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()

  var body: some View {
      VStack {
          if authViewModel.isSignedIn {
              TabView {
                  MovieListView()
                      .tabItem {
                          Label("Filmler", systemImage: "film")
                      }
                  
                  FavoritesView()
                      .tabItem {
                          Label("Favoriler", systemImage: "heart.fill")
                      }
                      .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
              }
          } else {
              LoginView()
                  .environmentObject(authViewModel)
          }
      }
      .onAppear {
          print("ContentView yüklendi, isSignedIn: \(authViewModel.isSignedIn)")
      }
  }

}

//#Preview {
//    ContentView()
//        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}

#Preview { ContentView()
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext) .environmentObject(AuthViewModel()) }
