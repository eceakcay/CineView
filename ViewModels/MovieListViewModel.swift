//
//  MovieListViewModel.swift
//  FilmIncelemeApp
//
//  Created by Ece Akcay on 6.05.2025.
//

import Foundation

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?
    private let service = TMDBService()

func fetchMovies() async {
    do {
        movies = try await service.fetchPopularMovies()
        errorMessage = nil
    } catch {
        errorMessage = "Filmler yüklenemedi: \(error.localizedDescription)"
        print("Hata: \(error)")
    }
}

static var preview: MovieListViewModel {
    let viewModel = MovieListViewModel()
    viewModel.movies = [
        Movie(id: 1, title: "Örnek Film 1", overview: "Bu bir örnek filmdir.", posterPath: nil, releaseDate: "2023-01-01"),
        Movie(id: 2, title: "Örnek Film 2", overview: "Bu başka bir örnek filmdir.", posterPath: "/example.jpg", releaseDate: "2023-02-01")
    ]
    return viewModel
}

}
