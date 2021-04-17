//
//  Business.swift
//  MapsList
//
//  Created by Hovak Davtyan on 16.04.21.
//

// MARK: - Business

import Foundation

struct Business: Decodable, Hashable {
    let placeId: String
    let placeName: String
    let icon: URL?
    let address: String
    let longitude: Double
    let latitude: Double

    var processedAddress: String {
        address.replacingOccurrences(of: ", ", with: "\n")
    }
}
