//
//  MoviesListRepositoryImpl.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 26/08/2025.
//

import Foundation

final class MoviesListRepositoryImpl: MoviesListRepository {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func fetchTopRatedMovies(page: Int) async throws -> MoviesList {
        do {
            let endpoint = MoviesListAPI.topRatedMovies(page: page)
            let response: MoviesListResponseDTO? = try await networkService.requestAsync(endpoint, responseType: MoviesListResponseDTO.self)
            print("RESPONSEINCOMING: \(String(describing: response))")
            return MoviesList(
                movies: response?.results?.compactMap { $0.toDomain() } ?? [],
                page: response?.page ?? 1,
                totalPages: response?.totalPages ?? 1)
            // let moviesDTOs = responseDTO?.results ?? []
            //  return moviesDTOs.map { $0.toDomain() }
        } catch {
            let networkError = error.asNetworkError
            throw networkError
        }
    }
    
}
