import SwiftUI
import Kingfisher

 struct FavoritesView: View {
     @Environment(\.managedObjectContext) private var context
     @StateObject private var viewModel = FavoritesViewModel(context: PersistenceController.shared.container.viewContext)

       var body: some View {
           NavigationStack {
               List(viewModel.favorites) { favorite in
                   NavigationLink {
                       MovieDetailView(movie: Movie(
                           id: Int(favorite.id),
                           title: favorite.title ?? ""  ,
                           overview: favorite.overview ?? "",
                           posterPath: favorite.posterPath,
                           releaseDate: favorite.releaseDate ?? ""
                       ))
                   } label: {
                       HStack {
                           if let posterPath = favorite.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
                               KFImage(url)
                                   .placeholder { ProgressView() }
                                   .resizable()
                                   .scaledToFit()
                                   .frame(width: 100, height: 150)
                                   .clipped()
                                   .cornerRadius(8)
                                   .shadow(radius: 2)
                           } else {
                               Image(systemName: "photo")
                                   .resizable()
                                   .scaledToFit()
                                   .frame(width: 100, height: 150)
                                   .foregroundColor(.gray)
                           }
                           VStack(alignment: .leading, spacing: 4) {
                               Text(favorite.title ?? "")
                                   .font(.headline)
                                   .lineLimit(1)
                               Text(favorite.overview ?? "")
                                   .font(.subheadline)
                                   .lineLimit(2)
                                   .foregroundColor(.secondary)
                           }
                       }
                       .padding(.vertical, 4)
                   }
               }
               .navigationTitle("Favoriler")
               .overlay {
                   if viewModel.favorites.isEmpty {
                       Text("Henüz favori filminiz yok.")
                           .foregroundColor(.gray)
                   }
               }
               .task {
                   await viewModel.fetchFavorites()
               }
           }
       }

     }

#Preview {
    FavoritesView() .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
