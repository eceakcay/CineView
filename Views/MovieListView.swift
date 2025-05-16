//
//  MovieListView.swift
//  FilmIncelemeApp
//
//  Created by Ece Akcay on 6.05.2025.
//

import SwiftUI
import Kingfisher

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()

var body: some View {
    NavigationStack {
        List(viewModel.movies) { movie in
            NavigationLink {
                MovieDetailView(movie: movie)
            } label: {
                HStack {
                    if let url = movie.posterURL {
                        KFImage(url)
                            .placeholder { ProgressView() }
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 150)
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
                        Text(movie.title)
                            .font(.headline)
                            .lineLimit(1)
                        Text(movie.overview)
                            .font(.subheadline)
                            .lineLimit(2)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Popüler Filmler")
        .overlay {
            if let error = viewModel.errorMessage {
                VStack {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                    Button("Tekrar Dene") {
                        Task {
                            await viewModel.fetchMovies()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
}

}

#Preview {
    struct PreviewView: View {
        var body: some View {
            MovieListView() .environmentObject(MovieListViewModel.preview)
        }
    }
    return PreviewView()
}
