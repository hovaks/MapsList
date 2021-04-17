//
//  BusinessResponse.swift
//  MapsList
//
//  Created by Hovak Davtyan on 17.04.21.
//

import Foundation

// MARK: - BusinessesResponse

struct BusinessesResponse: Decodable {
    let nextPageToken: String?
    let businesses: [Business]
}
