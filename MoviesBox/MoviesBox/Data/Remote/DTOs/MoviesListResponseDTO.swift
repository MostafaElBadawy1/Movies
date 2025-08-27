//
//  MoviesListResponseDTO.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//

import Foundation

// MARK: - MoviesList
struct MoviesListResponseDTO: Decodable {
    let page: Int?
    let results: [MovieResponseDTO]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieResponseDTO: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func toDomain() -> MovieListItem {
        MovieListItem(
            id: id ?? 0,
            title: title ?? "",
            posterURL: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"),
            rating: String(format: "%.1f", voteAverage ?? 0),
            releaseDate: DateFormatterHelper.parse(releaseDate ?? "")
        )
    }
}

//extension Movie {
//   
//}
