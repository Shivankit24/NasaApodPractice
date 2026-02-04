//
//  AstronomyPictureService.swift
//  ApodNASA
//
//  Created by Shivankit on 03/02/2026.
//

import Foundation

protocol AstronomyPictureServiceProtocol {
    func fetchDailyContent() async throws -> AstronomyPicture
}
