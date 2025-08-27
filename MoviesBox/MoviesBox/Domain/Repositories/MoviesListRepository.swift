//
//  MoviesListRepository.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 15/05/2025.
//

import Foundation

protocol MoviesListRepository {
    func fetchTopRatedMovies(page: Int) async throws -> MoviesList
}
