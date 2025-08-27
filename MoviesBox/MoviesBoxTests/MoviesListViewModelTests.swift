//
//  MoviesListViewModelTests.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 25/05/2025.
//


import XCTest
@testable import MoviesBox

@MainActor
final class MoviesListViewModelTests: XCTestCase {
    
    private var sut: MoviesListViewModel!
    private var mockUseCase: MockFetchTopRatedMoviesUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchTopRatedMoviesUseCase()
        sut = MoviesListViewModel(fetchTopRatedMoviesUseCase: mockUseCase)
    }
    
    override func tearDown() {
        sut = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    // Test Success Scenario
    func testFetchMoviesSuccess() async {
        // Arrange
        let expectedItems = [
            MovieListItem(id: 1, title: "Movie 1", posterURL: URL(string: "https://a") , rating: "8.0", releaseDate: "Jun 1, 2024"),
            MovieListItem(id: 2, title: "Movie 2", posterURL: URL(string: "https://b"), rating: "7.1", releaseDate: "Jun 2, 2024")
        ]
        let list = MoviesList(movies: expectedItems, page: 1, totalPages: 1)
        mockUseCase.result = .success(list)
        
        // Act
        await sut.fetchMovies(reset: true)
        
        // Assert
        XCTAssertEqual(sut.movies, expectedItems)
        XCTAssertEqual(sut.viewState, .loaded)
        XCTAssertNil(sut.errorMessage)
    }
    
    // Test Failure Scenario
    func testFetchMoviesFailure() async {
        // Arrange
        let expectedError = NSError(domain: "Test", code: -1, userInfo: [NSLocalizedDescriptionKey: "Test Error"])
        mockUseCase.result = .failure(expectedError)
        
        // Act
        await sut.fetchMovies(reset: true)
        
        // Assert
        XCTAssertTrue(sut.movies.isEmpty)
        XCTAssertEqual(sut.viewState, .loaded) // we end loading even on error per current impl
        XCTAssertEqual(sut.errorMessage, expectedError.localizedDescription)
    }
}
