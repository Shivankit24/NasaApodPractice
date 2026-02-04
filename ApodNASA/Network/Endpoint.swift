//
//  Endpoint.swift
//  ApodNASA
//
//  Created by Shivankit on 04/02/2026.
//

import Foundation

protocol Endpoint {
    var baseURLString: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String : String]? { get }
}

extension Endpoint {
    var baseURLString: String {
        "https://api.nasa.gov"
    }

    func makeUrlRequest() throws -> URLRequest {
        guard let baseURL = URL(string: baseURLString) else {
            throw NetworkError.invalidURL
        }

        var components = URLComponents(url: baseURL.appending(path: path), resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }
}
