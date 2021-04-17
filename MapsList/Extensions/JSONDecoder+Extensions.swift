//
//  JSONDecoder+Extensions.swift
//  MapsList
//
//  Created by Hovak Davtyan on 17.04.21.
//

import Foundation

extension JSONDecoder {
    static var `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
