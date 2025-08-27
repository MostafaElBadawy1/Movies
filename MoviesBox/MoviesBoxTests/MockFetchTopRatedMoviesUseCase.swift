//
//  MockFetchTopRatedMoviesUseCase.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 25/05/2025.
//

import XCTest
@testable import MoviesBox

final class MockFetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCase {
    var result: Result<[MovieListItem], Error> = .success([])
    
    func execute(page: Int) async throws -> [MovieListItem] {
        switch result {
        case .success(let movies):
            return movies
        case .failure(let error):
            throw error
        }
    }
}
