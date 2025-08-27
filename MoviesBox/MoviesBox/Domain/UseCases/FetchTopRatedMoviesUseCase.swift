//
//  FetchTopRatedMoviesUseCase.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 26/08/2025.
//

import Foundation

protocol FetchTopRatedMoviesUseCase {
    func execute(page: Int) async throws -> MoviesList
}

final class FetchTopRatedMoviesUseCaseImpl: FetchTopRatedMoviesUseCase {
    private let repository: MoviesListRepository
    
    init(repository: MoviesListRepository) {
        self.repository = repository
    }
    
    func execute(page: Int) async throws -> MoviesList {
        return try await repository.fetchTopRatedMovies(page: page)
    }
}
