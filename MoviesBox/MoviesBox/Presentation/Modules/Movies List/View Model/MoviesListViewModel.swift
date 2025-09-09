//
//  MoviesListViewModel.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 26/08/2025.
//

import Foundation
import Combine

@MainActor
final class MoviesListViewModel: ObservableObject {
    
    // MARK: - Input
    private let fetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCase
    
    // MARK: - Output
    @Published private(set) var viewState: ViewState = .idle
    @Published private(set) var movies: [MovieListItem] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var selectedMovie: MovieListItem? = nil
    
    // MARK: - Pagination
    private var currentPage = 1
    private var totalPages = 1
    private var isFetching = false
   
    
    // MARK: - Init
    init(fetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCase) {
        self.fetchTopRatedMoviesUseCase = fetchTopRatedMoviesUseCase
    }
    
    // MARK: - Public Methods
    
    func fetchMovies(reset: Bool = false) async {
        guard !isFetching else { return }
        
        if reset {
            currentPage = 1
            totalPages = 1
        }
        
        guard currentPage <= totalPages else { return }
        
        if currentPage == 1 {
            viewState = .loading
        } else {
            viewState = .paginating
        }
        isFetching = true
        
        do {
            let movieList = try await fetchTopRatedMoviesUseCase.execute(page: currentPage)
            
            if currentPage == 1 {
                self.movies = movieList.movies
            } else {
                self.movies.append(contentsOf: movieList.movies)
            }
            currentPage += 1
            totalPages = movieList.totalPages
            viewState = .loaded
        } catch {

            let networkError = error.asNetworkError
            self.errorMessage = networkError.errorDescription
            print("zzzzzz\(networkError.errorDescription)")
            viewState = .loaded
           // viewState = .error(networkError.errorDescription ?? "")
        }
        isFetching = false
    }
    
    
    func retry() {
        Task {
            await fetchMovies(reset: true)
        }
    }
}

