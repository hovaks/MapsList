//
//  BusinessTableViewCell.swift
//  MapsList
//
//  Created by Hovak Davtyan on 16.04.21.
//

import Kingfisher
import MapKit
import UIKit

final class BusinessTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet private var mapView: MKMapView! {
        didSet { configureMapView() }
    }

    private func configureMapView() {
        mapView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mapView.layer.cornerRadius = 10
        mapView.layer.masksToBounds = true
        mapView.isScrollEnabled = false
    }

    @IBOutlet private var containerView: UIView! {
        didSet { configureContainerView() }
    }

    private func configureContainerView() {
        containerView.setCornerRadius(to: 10)
        containerView.addShadow()
    }

    @IBOutlet private var logoImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var starRatingView: StarRatingView!

    // MARK: - Injection

    var business: Business! {
        didSet { configure() }
    }

    private func configure() {
        configureMap()
        logoImageView.isHidden = business.icon == nil
        if let url = business.icon {
            logoImageView.kf.setImage(with: url)
        }
        nameLabel.text = business.placeName
        addressLabel.text = business.processedAddress
        let rating = Double.random(in: 1 ... 5)
        ratingLabel.text = rating.roundedString(to: 1)
        starRatingView.rating = rating
    }

    private func configureMap() {
        let coordinate = CLLocationCoordinate2D(latitude: business.latitude, longitude: business.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: false)
        mapView.addAnnotation(annotation)
    }
}
