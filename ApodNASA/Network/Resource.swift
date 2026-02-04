//
//  Endpoint.swift
//  ApodNASA
//
//  Created by Shivankit on 04/02/2026.
//

import Foundation

struct Resource<T: Decodable> {
    let baseURLString: String
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]?
    let headers: [String : String]?

    func toURLRequest() throws -> URLRequest {
        guard var components = URLComponents(string: baseURLString) else {
            throw URLError(.badURL)
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }

    init(
        baseURLString: String,
        path: String,
        method: HTTPMethod = .get,
        queryItems: [URLQueryItem]? = nil,
        headers: [String : String]? = nil
    ) {
        self.baseURLString = baseURLString
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
    }
}
