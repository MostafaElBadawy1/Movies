//
//  NetworkManager.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//

import Foundation

//class NetworkManager {
//    private let router: NetworkRouter
//    
//    init(router: NetworkRouter) {
//        self.router = router
//    }
//    
//    func request<T: Decodable>(endpoint: String, method: HTTPMethod, parameters: NetworkParameters? = nil) async throws -> T {
//        let request = try router.makeURLRequest()
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
//            return decodedResponse
//        } catch {
//            throw NetworkError.requestFailed
//        }
//    }
//}
//final class NetworkManager {
//    private let router: NetworkRouter
//    
//    init(router: NetworkRouter) {
//        self.router = router
//    }
//    
//    func request<T: Decodable>(endpoint: NetworkRouter) async throws -> T {
//        let request = try router.makeURLRequest(for: endpoint)
//        
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request)
//            
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                throw NetworkError.invalidResponse
//            }
//            
//            let decoded = try JSONDecoder().decode(T.self, from: data)
//            return decoded
//            
//        } catch let decodingError as DecodingError {
//            throw NetworkError.decodingFailed(decodingError)
//        } catch {
//            throw NetworkError.requestFailed(error)
//        }
//    }
//}
