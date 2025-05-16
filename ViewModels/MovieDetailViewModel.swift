import Foundation

@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var errorMessage: String?
    private let service = CommentService()

func fetchComments(for movieId: Int) async {
    do {
        comments = try await service.fetchComments(for: movieId)
        errorMessage = nil
        print("Yorumlar başarıyla yüklendi: \(comments.count) yorum")
    } catch {
        errorMessage = "Yorumlar yüklenemedi: \(error.localizedDescription)"
        print("Yorumlar yüklenemedi: \(error)")
    }
}

func addComment(movieId: Int, text: String, userId: String, userEmail: String) async {
    let comment = Comment(
        id: nil,
        movieId: movieId,
        userId: userId,
        userEmail: userEmail,
        text: text,
        timestamp: Date()
    )
    do {
        try await service.addComment(comment)
        await fetchComments(for: movieId) // Yorumları güncelle
        print("Yorum eklendi ve liste güncellendi")
    } catch {
        errorMessage = "Yorum eklenemedi: \(error.localizedDescription)"
        print("Yorum eklenemedi: \(error)")
    }
}

}
