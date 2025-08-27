//
//  NetworkRouter.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//

//import Foundation
//
//enum NetworkRouter: URLRequestConvertible {
//    
//    case fetchMoviesList(String, Int)
//    case fetchMovieDetails(String)
//    
//    var baseURL: String {
//            "https://api.themoviedb.org/3/"
//        }
//    
//    var path: String {
//        switch self {
//        case .fetchMoviesList:
//            return ""
//        case .fetchMovieDetails(let movieID):
//            return "\(movieID)"
//        }
//    }
//    var method: HTTPMethod {
//        switch self {
//         case .fetchMoviesList, .fetchMovieDetails:
//            return .get
//        }
//    }
//    var parameters: [String: String]? {
//        switch self {
//        case .fetchMoviesList(let sortType, let pageNum):
//            return ["sort_by": sortType, "page": "\(pageNum)"]
//        case .fetchMovieDetails(let pageNumber):
//            return nil
//        }
//    }
//    func makeURLRequest() throws -> URLRequest {
//       
//        guard var urlComponents = URLComponents(string: baseURL + path) else {
//            throw NetworkError.invalidURL
//        }
//        
//        if let parameters = parameters {
//            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
//        }
//        
//        guard let finalURL = urlComponents.url else {
//            throw NetworkError.invalidURL
//        }
//        
//        var request = URLRequest(url: finalURL)
//        request.httpMethod = method.rawValue
//        
//        request.setValue("Bearer \(AuthManager.shared.token)", forHTTPHeaderField: "Authorization")
//
//        
//        return request
//    }
//}
//
//enum HTTPMethod: String {
//    case get = "GET"
//    case post = "POST"
//    case put = "PUT"
//    case delete = "DELETE"
//}
//
//protocol URLRequestConvertible {
//    func makeURLRequest(for endpoint: NetworkRouter) throws -> URLRequest
//}
//enum NetworkError: Error {
//    case invalidURL
//    case requestFailed(statusCode: Int)
//    case invalidResponse
//    case dataConversionFailure
//}
final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    var token: String = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjM2JjOWFiNmVlN2RhMjhjOGIwOTk3ZWY1NDhlZjRiOCIsIm5iZiI6MS43NDcyMjk4MjIxMDA5OTk4ZSs5LCJzdWIiOiI2ODI0OWM3ZTQ5MzNmZTE0NTUzMzNmZTEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.UC0N_KwQ2-CJ83jAtCj_JLmnAhBQSVHfOPdW_MHxn3g"
}

//final class DefaultRouter: URLRequestConvertible {
//    func makeURLRequest(for endpoint: NetworkRouter) throws -> URLRequest {
//        try endpoint.makeURLRequest()
//    }
//}
