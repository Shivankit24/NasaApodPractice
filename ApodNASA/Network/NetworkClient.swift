//
//  NetworkClient.swift
//  ApodNASA
//
//  Created by Shivankit on 03/02/2026.
//

import Foundation

protocol NetworkClientProtocol {
    func performRequest<T: Decodable>(for resource: Resource<T>) async throws -> T
}

final class NetworkClient: NetworkClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        session: URLSession = URLSession(configuration: .default),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }

    func performRequest<T: Decodable>(for resource: Resource<T>) async throws -> T {
        let request = try resource.toURLRequest()
        let (data, response): (Data, URLResponse)

        do {
            (data, response) = try await session.data(for: request)
        } catch let error as URLError where error.code == .notConnectedToInternet {
            throw NetworkError.noInternet
        } catch {
            throw NetworkError.unknown(error)
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
