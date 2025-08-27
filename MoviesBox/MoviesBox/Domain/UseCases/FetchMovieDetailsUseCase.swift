//
//  FetchMovieDetailsUseCase.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 25/08/2025.
//

import Foundation

protocol FetchMovieDetailsUseCase {
    func execute(movieId: Int) async throws -> MovieDetails
}

final class FetchMovieDetailsUseCaseImpl: FetchMovieDetailsUseCase {
    private let repository: MovieDetailsRepository
    
    init(repository: MovieDetailsRepository) {
        self.repository = repository
    }
    
    func execute(movieId: Int) async throws -> MovieDetails {
        return try await repository.fetchMovieDetails(movieId: movieId)
    }
}
