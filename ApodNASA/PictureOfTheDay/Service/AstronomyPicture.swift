//
//  AstronomyPicture.swift
//  ApodNASA
//
//  Created by Shivankit on 03/02/2026.
//

import Foundation

struct AstronomyPicture: Decodable {
    // Mandatory
    let title: String
    let date: String
    let url: String
    let mediaType: MediaType
    let explanation: String

    // Optional
    let hdURL: URL?
    let copyright: String?
    let serviceVersion: String?

    private enum CodingKeys: String, CodingKey {
        case title
        case date
        case url
        case mediaType = "media_type"
        case explanation
        case hdURL
        case copyright
        case serviceVersion = "service_version"
    }
}

enum MediaType: String, Decodable {
    case image
    case video
    case other  // just-in-case
}
