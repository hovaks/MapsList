//
//  SearchViewController.swift
//  MapsList
//
//  Created by Hovak Davtyan on 17.04.21.
//

import UIKit

// MARK: - SearchViewController

final class SearchViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet private var emptyIndicatorView: UIView!
    @IBOutlet private var searchBar: UISearchBar! {
        didSet { searchBar.delegate = self }
    }

    // MARK: - Network

    private var query: String?
    private var businesses: [Business] = []
    private var nextPageToken: String?

    private func getBusinesses(for query: String) {
        BusinessesService.shared.getBusinesses(with: .init(input: query)) { businesses, token in
            self.businesses = businesses
            self.nextPageToken = token
            DispatchQueue.main.async { [weak self] in
                self?.emptyIndicatorView.isHidden = !businesses.isEmpty
                if !businesses.isEmpty {
                    self?.performSegue(withIdentifier: "BusinessesSegue", sender: self)
                }
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? BusinessesViewController else { return }
        destination.query = query
        destination.businesses = businesses
        destination.nextPageToken = nextPageToken
    }
}

// MARK: UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let query = searchBar.text, !query.isEmpty else { return }
        self.query = query
        getBusinesses(for: query)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        emptyIndicatorView.isHidden = true
    }
}
