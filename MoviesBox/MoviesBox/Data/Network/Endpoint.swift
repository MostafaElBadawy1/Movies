//
//  Endpoint.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var queryParameters: [String: String]? { get }
    var body: Data? { get }
}
//https://api.themoviedb.org/3/movie/top_rated
//https://api.themoviedb.org/3/movie/movie_id
extension Endpoint {
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String: String]? {
        return ["Authorization": "Bearer \(AuthManager.shared.token)"]
    }
    
    var body: Data? {
        return nil
    }
    
    func urlRequest() throws -> URLRequest {
        guard var urlComponents = URLComponents(string: baseURL + path) else {
            throw NetworkError.invalidURL
        }

        if let queryParameters = queryParameters {
            urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}

enum NetworkError: LocalizedError {
    case invalidURL
    case timeout
    case noInternet
    case serverError(String)
    case decodingError
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "The requested URL is invalid."
            case .timeout:
                return "Request timed out. Please try again."
            case .noInternet:
                return "No internet connection. Check your network and try again."
            case .serverError(let message):
                return "Server error: \(message)"
            case .decodingError:
                return "Data decoding failed. Please try again."
            case .unknown(let error):
                return error.localizedDescription
        }
    }
}

extension Error {
    var asNetworkError: NetworkError {
        if let urlError = self as? URLError {
            switch urlError.code {
                case .unsupportedURL, .badURL:
                    return .invalidURL
                case .timedOut:
                    return .timeout
                case .notConnectedToInternet:
                    return .noInternet
                default:
                    return .unknown(self)
            }
        } else if let decodingError = self as? DecodingError {
            return .decodingError
        } else {
            return .unknown(self)
        }
    }
}

