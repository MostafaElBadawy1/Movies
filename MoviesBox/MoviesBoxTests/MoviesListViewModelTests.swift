//
//  MoviesListViewModelTests.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 25/05/2025.
//


import XCTest
@testable import MoviesBox

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
        let expectedMovies = [
            MovieListItem(id: 1, title: "Movie 1", posterURL: URL("1"), rating: "1", releaseDate: "2"),
            MovieListItem(id: 2, title: "Movie 2", posterURL:URL("2"), rating: "2", releaseDate: "2")
        ]
        mockUseCase.result = .success(expectedMovies)
        
        // Act
        await sut.fetchMovies()
        
        // Assert
        XCTAssertEqual(sut.movies, expectedMovies)
        XCTAssertEqual(sut.viewState, .loaded)
        XCTAssertNil(sut.error)
    }
    
    // Test Failure Scenario
    func testFetchMoviesFailure() async {
        // Arrange
        let expectedError = NSError(domain: "Test", code: -1, userInfo: [NSLocalizedDescriptionKey: "Test Error"])
        mockUseCase.result = .failure(expectedError)
        
        // Act
        await sut.fetchMovies()
        
        // Assert
        XCTAssertTrue(sut.movies.isEmpty)
        XCTAssertEqual(sut.viewState, .error("Test Error"))
        XCTAssertEqual(sut.error?.localizedDescription, "Test Error")
    }
}
