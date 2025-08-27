//
//  MovieDetailsRepository.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 15/05/2025.
//

import Foundation

protocol MovieDetailsRepository {
    func fetchMovieDetails(movieId: Int) async throws -> MovieDetails
}
