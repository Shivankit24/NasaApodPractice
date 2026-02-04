//
//  AstronomyPictureEndpoint.swift
//  ApodNASA
//
//  Created by Shivankit on 04/02/2026.
//

import Foundation

enum AstronomyPictureResource {
    static func getPictureOfTheDay(date: String?) -> Resource<AstronomyPicture> {
        let baseURLString = "https://api.nasa.gov"
        let path = "/planetary/apod"
        let queryItems = [
            URLQueryItem(name: "api_key", value: "DEMO_KEY"),
            URLQueryItem(name: "date", value: date)
        ]

        return Resource(baseURLString: baseURLString, path: path, queryItems: queryItems)
    }
}
