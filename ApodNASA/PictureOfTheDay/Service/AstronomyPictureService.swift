//
//  AstronomyPictureService.swift
//  ApodNASA
//
//  Created by Shivankit on 03/02/2026.
//

import Foundation

protocol AstronomyPictureServiceProtocol {
    func fetchDailyContent(date: String?) async throws -> AstronomyPicture?
}

final class AstronomyPictureService: AstronomyPictureServiceProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = NetworkClient()) {
        self.client = client
    }

    func fetchDailyContent(date: String?) async throws -> AstronomyPicture? {
        do {
            let resource = AstronomyPictureResource.getPictureOfTheDay(date: date)
            return try await client.performRequest(for: resource)
        } catch {
            print("Couldn't fetch daily content, reason: \(error)")
            return nil
        }
    }
}
