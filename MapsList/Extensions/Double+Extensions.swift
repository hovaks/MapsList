//
//  Double+Extensions.swift
//  MapsList
//
//  Created by Hovak Davtyan on 17.04.21.
//

import Foundation

extension Double {
    func roundedString(to places: Int) -> String {
        String(format: "%.\(places)f", self)
    }
}
