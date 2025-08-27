//
//  MockFetchTopRatedMoviesUseCase.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 25/05/2025.
//

import XCTest
@testable import MoviesBox

final class MockFetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCase {
    var result: Result<MoviesList, Error> = .success(MoviesList(movies: [], page: 1, totalPages: 1))
    
    func execute(page: Int) async throws -> MoviesList {
        switch result {
        case .success(let list):
            return list
        case .failure(let error):
            throw error
        }
    }
}
