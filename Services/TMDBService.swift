//
//  TMDBService.swift
//  FilmIncelemeApp
//
//  Created by Ece Akcay on 6.05.2025.
//

import Foundation

class TMDBService {
    private let apiKey = "542ff9c1fdba20c0bc20d7698b98de01"
    private let baseURL = "https://api.themoviedb.org/3"
    
    //fetchPopularMovies, async/await ile TMDB’ye HTTP GET isteği gönderir.
    func fetchPopularMovies() async throws -> [Movie] {
        guard let url = URL(string: "\(baseURL)/movie/popular?api_key=\(apiKey)") else {
            throw URLError(.badURL)
        }
        //URLSession ile veri çekilir
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        //JSONDecoder ile MovieResponse’a çevrilir
        let decoder = JSONDecoder()
        let responseData = try decoder.decode(MovieResponse.self, from: data)
        return responseData.results
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}
