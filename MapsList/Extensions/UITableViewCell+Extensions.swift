//
//  UITableView+Extensions.swift
//  MapsList
//
//  Created by Hovak Davtyan on 16.04.21.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
