//
//  MovieAPI.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 15/05/2025.
//

import Foundation

struct MoviesListAPI: Endpoint {
    var path: String
    var method: String = "GET"
    var queryParameters: [String: String]?

    static func topRatedMovies(page: Int) -> MoviesListAPI {
        return MoviesListAPI(path: "/movie/top_rated", queryParameters: ["page": "\(page)"])
    }
}
