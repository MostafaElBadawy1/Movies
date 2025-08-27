//
//  MovieDetailsRepositoryImpl.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 25/08/2025.
//

import Foundation

final class MovieDetailsRepositoryImpl: MovieDetailsRepository {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func fetchMovieDetails(movieId: Int) async throws -> MovieDetails {
        let endpoint = MovieDetailsAPI.movieDetails(movieId: movieId)
        let responseDTOs: MovieDetailsResponseDTO = try await networkService.requestAsync(endpoint, responseType: MovieDetailsResponseDTO.self)
        return responseDTOs.toDomain()
    }
}
