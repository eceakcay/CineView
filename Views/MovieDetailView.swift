import SwiftUI
import Kingfisher
import FirebaseAuth

struct MovieDetailView: View { 
    let movie: Movie
    @StateObject private var viewModel = MovieDetailViewModel()
    @StateObject private var favoriteViewModel = FavoriteViewModel(context: PersistenceController.shared.container.viewContext)
    @State private var newComment = ""

  var body: some View {
      ScrollView {
          VStack(alignment: .leading, spacing: 16) {
              // Film Posteri
              if let url = movie.posterURL {
                  KFImage(url)
                      .placeholder { ProgressView() }
                      .resizable()
                      .scaledToFit()
                      .frame(width: 300, height: 300)
                      .clipped()
                      .cornerRadius(12)
                      .shadow(radius: 4)
              } else {
                  Image(systemName: "photo")
                      .resizable()
                      .scaledToFit()
                      .frame(width: 300, height: 300)
                      .foregroundColor(.gray)
              }
              
              // Film Bilgileri
              Text(movie.title)
                  .font(.title)
                  .bold()
              Text(movie.overview)
                  .font(.body)
                  .foregroundColor(.secondary)
              if let releaseDate = movie.releaseDate {
                  Text("Çıkış Tarihi: \(releaseDate)")
                      .font(.subheadline)
              }
              
              // Favori Butonu
              Button(action: {
                  do {
                      if try favoriteViewModel.isFavorite(movieId: movie.id) {
                          try favoriteViewModel.removeFavorite(movieId: movie.id)
                      } else {
                          try favoriteViewModel.addFavorite(movie: movie)
                      }
                  } catch {
                      print("Favori işlemi başarısız: \(error)")
                  }
              }) {
                  Label(
                      favoriteViewModel.isFavorite ? "Favorilerden Çıkar" : "Favorilere Ekle",
                      systemImage: favoriteViewModel.isFavorite ? "heart.fill" : "heart"
                  )
                  .foregroundColor(.red)
                  .padding()
                  .background(Color(.systemGray6))
                  .cornerRadius(8)
              }
              .padding(.vertical)
              
              // Yeni Yorum Ekleme
              VStack(alignment: .leading, spacing: 8) {
                  Text("Yorum Yap")
                      .font(.headline)
                  TextField("Yorumunuzu yazın...", text: $newComment)
                      .textFieldStyle(.roundedBorder)
                      .autocapitalization(.sentences)
                  Button("Gönder") {
                      Task {
                          await viewModel.addComment(
                              movieId: movie.id,
                              text: newComment,
                              userId: Auth.auth().currentUser?.uid ?? "",
                              userEmail: Auth.auth().currentUser?.email ?? ""
                          )
                          newComment = ""
                      }
                  }
                  .buttonStyle(.borderedProminent)
                  .disabled(newComment.isEmpty)
              }
              .padding(.vertical)
              
              // Yorumlar
              Text("Yorumlar")
                  .font(.headline)
              if let error = viewModel.errorMessage {
                  Text(error)
                      .foregroundColor(.red)
                      .padding()
              } else if viewModel.comments.isEmpty {
                  Text("Henüz yorum yok.")
                      .foregroundColor(.gray)
              } else {
                  ForEach(viewModel.comments) { comment in
                      VStack(alignment: .leading, spacing: 4) {
                          Text(comment.userEmail)
                              .font(.subheadline)
                              .bold()
                          Text(comment.text)
                              .font(.body)
                          Text(comment.timestamp, style: .date)
                              .font(.caption)
                              .foregroundColor(.gray)
                      }
                      .padding(.vertical, 4)
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .background(Color(.systemGray6))
                      .cornerRadius(8)
                  }
              }
          }
          .padding()
      }
      .navigationTitle(movie.title)
      .navigationBarTitleDisplayMode(.inline)
      .task {
          print("MovieDetailView yüklendi, movieId: \(movie.id)")
          await viewModel.fetchComments(for: movie.id)
          favoriteViewModel.checkFavorite(movieId: movie.id) // await kaldırıldı
      }
  }

}

#Preview {
    MovieDetailView(movie: Movie(id: 1, title: "Örnek Film", overview: "Bu bir örnek filmdir.", posterPath: nil, releaseDate: "2023-01-01")) .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
