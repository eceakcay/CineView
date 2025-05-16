//
//  CommentService.swift
//  FilmIncelemeApp
//
//  Created by Ece Akcay on 6.05.2025.
//

import Foundation
import FirebaseFirestore

class CommentService {
    private let db = Firestore.firestore()
    private let collectionPath = "comments"

//Yeni bir yorumu Firestore’a ekler.
func addComment(_ comment: Comment) async throws {
    try db.collection(collectionPath).addDocument(from: comment)
}

//Belirli bir filme (movieId) ait yorumları çeker, en yeniler önce olacak şekilde sıralar.
    func fetchComments(for movieId: Int) async throws -> [Comment] {
        print("Yorumlar çekiliyor, movieId: \(movieId)")
        let snapshot = try await db.collection(collectionPath)
            .whereField("movie_id", isEqualTo: movieId)
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        let comments = snapshot.documents.compactMap { document in
            do {
                let comment = try document.data(as: Comment.self)
                print("Yorum alındı: \(comment.text)")
                return comment
            } catch {
                print("Yorum çözülememedi: \(error)")
                return nil
            }
        }
        
        print("Toplam \(comments.count) yorum bulundu")
        return comments
    }

}
