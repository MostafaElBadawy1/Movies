//
//  NetworkService.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//


import Foundation
import Combine

protocol NetworkService {
    func request<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) -> AnyPublisher<T, NetworkError>
    func requestAsync<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T
}

final class NetworkServiceImpl: NetworkService {
    
    func request<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) -> AnyPublisher<T, NetworkError> {
        do {
            let request = try endpoint.urlRequest()
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result in
                    guard let httpResponse = result.response as? HTTPURLResponse else {
                        throw NetworkError.unknown(URLError(.badServerResponse))
                    }
                    guard (200...299).contains(httpResponse.statusCode) else {
                        throw NetworkError.serverError("\(httpResponse.statusCode)")
                    }
                    return result.data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { error in
                    (error as? NetworkError) ?? NetworkError.unknown(error)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error as? NetworkError ?? .unknown(error))
                .eraseToAnyPublisher()
        }
    }

    func requestAsync<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T {
        let request = try endpoint.urlRequest()
        logRequest(request)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown(URLError(.badServerResponse))
        }
        logResponse(httpResponse)
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError("\(httpResponse.statusCode)")
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
    func logRequest(_ request: URLRequest) {
        print("""
    📤 REQUEST SENT:
    🧭 URL: \(request.url?.absoluteString ?? "nil")
    📬 METHOD: \(request.httpMethod ?? "nil")
    📦 HEADERS: \(request.allHTTPHeaderFields ?? [:])
    📝 BODY: \(request.httpBody.flatMap { String(data: $0, encoding: .utf8) } ?? "nil")
    """)
    }
    
    func logResponse(_ httpResponse: HTTPURLResponse) {
        print("""
📡🌐 HTTPURLResponse Received:
  🔢 Status Code: \(httpResponse.statusCode)
  🌍 URL: \(httpResponse.url?.absoluteString ?? "N/A")
  📦 Headers: \(httpResponse.allHeaderFields)
""")
    }
}
