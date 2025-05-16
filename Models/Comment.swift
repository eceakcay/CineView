//
//  Comment.swift
//  FilmIncelemeApp
//
//  Created by Ece Akcay on 6.05.2025.
//

import Foundation
import FirebaseFirestore

struct Comment: Codable, Identifiable {
    @DocumentID var id: String? // Firestore belge ID'si
    let movieId: Int // Hangi filme ait
    let userId: String // Yorumu yazan kullanıcı
    let userEmail: String // Kullanıcının e-postası (gösterim için)
    let text: String // Yorum metni
    let timestamp: Date // Yorumun tarihi

enum CodingKeys: String, CodingKey {
    case id
    case movieId = "movie_id"
    case userId = "user_id"
    case userEmail = "user_email"
    case text
    case timestamp
}

}
