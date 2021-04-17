//
//  StarRatingView.swift
//  MapsList
//
//  Created by Hovak Davtyan on 16.04.21.
//

import UIKit

// MARK: - StarRatingView

@IBDesignable class StarRatingView: UIView {
    // MARK: - Outlets

    @IBOutlet private var contentView: UIView! {
        didSet { configureContentView() }
    }

    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @IBOutlet private var starsStackView: UIStackView!

    // MARK: - Inspectables

    @IBInspectable var rating: Double = 0 {
        didSet { if oldValue != rating { configureStars() } }
    }

    private func configureStars() {
        guard let stackView = starsStackView else { return }
        let starImages = stackView.subviews.compactMap { $0 as? UIImageView }
        if rating == 0 { starImages.forEach { $0.tintColor = .systemGray } }
        starImages.enumerated().forEach { index, star in
            star.tintColor = index < Int(round(self.rating)) ? .systemYellow : .systemGray
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }

    private func loadNib() {
        let bundle = Bundle(for: StarRatingView.self)
        bundle.loadNibNamed(String(describing: StarRatingView.self), owner: self, options: nil)
    }
}
