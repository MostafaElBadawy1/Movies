//
//  MovieDetailsAPI.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//

import Foundation

struct MovieDetailsAPI: Endpoint {
    var path: String
    var method: String = "GET"
    var queryParameters: [String: String]?
    
    static func movieDetails(movieId: Int) -> MovieDetailsAPI {
        return MovieDetailsAPI(path: "/movie/\(movieId)")
    }
}
