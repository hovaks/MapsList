//
//  UIView+Extensions.swift
//  MapsList
//
//  Created by Hovak Davtyan on 17.04.21.
//

import UIKit

extension UIView {
    func setCornerRadius(to radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = radius > 0
    }

    func addShadow(
        of color: UIColor = .black,
        opacity: Float = 0.2,
        radius: CGFloat = 3,
        offset: CGSize = .init(width: 0, height: 3)
    ) {
        clipsToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
