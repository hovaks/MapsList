//
//  BusinessesService.swift
//  MapsList
//
//  Created by Hovak Davtyan on 17.04.21.
//

import Alamofire
import Foundation

// MARK: - BusinessesService

class BusinessesService {
    // MARK: - Singleton

    static let shared: BusinessesService = .init()
    private init() {}

    // MARK: - Constants

    private let baseURL = "https://8d7il1ul3f.execute-api.us-east-1.amazonaws.com/dev/businesses/"
    private let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiZkNvRlVmMk5MVllIIn0sImV4cCI6MTYxOTYxNDI5MCwiaWF0IjoxNjE4NDA0NjkwfQ.zceDUlGUHHiNm9V7eOt85rGOEkIPLIBqXe40PmpDTYo"

    private lazy var headers: HTTPHeaders = [
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-AUTH-TOKEN": token
    ]

    // MARK: - CRUD

    func getBusinesses(with parameters: BusinessesRequest, completion: @escaping ([Business], String?) -> ()) {
        guard let url = URL(string: baseURL) else { return }
        let encoder = URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(keyEncoding: .convertToSnakeCase))
        AF.request(
            url,
            parameters: parameters,
            encoder: encoder,
            headers: headers
        ).responseDecodable(
            of: BusinessesResponse.self,
            decoder: JSONDecoder.default
        ) { response in
            if let response = response.value {
                completion(response.businesses, response.nextPageToken)
            }
        }
    }
}
