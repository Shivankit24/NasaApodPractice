//
//  NetworkRequest.swift
//  ApodNASA
//
//  Created by Shivankit on 03/02/2026.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    // Add more methods here, if and when needed
}

struct NetworkRequest {
    let url: URL
    let method: HTTPMethod
    let queryItems: [URLQueryItem]?
    let headers: [String : String]?

    var finalURL: URL {
        guard let queryItems,
              var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return url
        }

        components.queryItems = queryItems
        return components.url ?? url
    }
}
