//
//  BusinessRequest.swift
//  MapsList
//
//  Created by Hovak Davtyan on 17.04.21.
//

import Foundation

// MARK: - BusinessesRequest

struct BusinessesRequest: Encodable {
    let input: String
    let nextPageToken: String?
    let includeFullData: Bool
    let latitude: Double
    let longitude: Double

    init(
        input: String,
        nextPageToken: String? = nil,
        includeFullData: Bool = true,
        latitude: Double = 40.7307693,
        longitude: Double = -73.9913223
    ) {
        self.input = input
        self.nextPageToken = nextPageToken
        self.includeFullData = includeFullData
        self.latitude = latitude
        self.longitude = longitude
    }
}
