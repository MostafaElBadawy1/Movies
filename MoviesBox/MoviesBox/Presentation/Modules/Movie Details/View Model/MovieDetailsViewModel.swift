//
//  MovieDetailsViewModel.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 26/08/2025.
//

import Foundation
import Combine

@MainActor
final class MovieDetailsViewModel: ObservableObject {
    // MARK: - Inputs
    private let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase
    private let movieId: Int

    // MARK: - Outputs
    @Published private(set) var viewState: ViewState = .idle
    @Published private(set) var details: MovieDetails?
    @Published var errorMessage: String?

    // MARK: - Init
    init(movieId: Int, fetchMovieDetailsUseCase: FetchMovieDetailsUseCase) {
        self.movieId = movieId
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
    }

    // MARK: - Public
    func load() async {
        viewState = .loading
        do {
            let result = try await fetchMovieDetailsUseCase.execute(movieId: movieId)
            self.details = result
            viewState = .loaded
        } catch {
            let networkError = error.asNetworkError
            self.errorMessage = networkError.errorDescription
            viewState = .loaded
        }
    }
}
