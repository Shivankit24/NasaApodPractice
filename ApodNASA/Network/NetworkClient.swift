//
//  NetworkClient.swift
//  ApodNASA
//
//  Created by Shivankit on 03/02/2026.
//

import Foundation

protocol NetworkClientProtocol {
    func execute<T: Decodable>(_ request: NetworkRequest) async throws -> T
}

final class NetworkClient: NetworkClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = URLSession(configuration: .default), decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func execute<T: Decodable>(_ request: NetworkRequest) async throws -> T {
        var urlRequest = URLRequest(url: request.finalURL)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: urlRequest)
        } catch {
            if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                throw NetworkError.noInternet
            } else {
                throw NetworkError.unknown(error)
            }
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.requestFailed(statusCode: 0)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.decodingError(httpResponse.statusCode)
        }

        return try decoder.decode(T.self, from: data)
    }
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingError(Int)
    case noInternet
    case unknown(Error)
}
