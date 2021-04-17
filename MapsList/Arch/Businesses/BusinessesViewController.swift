//
//  BusinessesViewController.swift
//  MapsList
//
//  Created by Hovak Davtyan on 16.04.21.
//

import UIKit

// MARK: - BusinessesViewController

final class BusinessesViewController: UIViewController {
    // MARK: - Dependencies

    var query: String!
    var businesses: [Business]! {
        didSet {
            guard oldValue != businesses else { return }
            DispatchQueue.main.async { [weak self] in
                self?.refreshTableView()
            }
        }
    }

    var nextPageToken: String?

    // MARK: - Outlets

    @IBOutlet private var tableView: UITableView! {
        didSet { tableView.delegate = self }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createDataSource()
    }

    // MARK: - TableView

    // MARK: DataSource

    private typealias TableViewDataSource = UITableViewDiffableDataSource<Section, Business>
    private typealias TableViewSnapshot = NSDiffableDataSourceSnapshot<Section, Business>
    private var isLoading = false

    private var datasource: TableViewDataSource!

    private func createDataSource() {
        datasource = TableViewDataSource(tableView: tableView) { tv, _, business in
            guard let cell = tv.dequeueReusableCell(withIdentifier: BusinessTableViewCell.reuseIdentifier)
                as? BusinessTableViewCell else { fatalError() }
            cell.business = business
            return cell
        }
    }

    // MARK: Refresh

    private func refreshTableView() {
        var snapshot = TableViewSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(businesses, toSection: .main)
        datasource.apply(snapshot)
    }

    // MARK: - Get Businesses

    private func getBusinesses() {
        guard nextPageToken != nil || businesses.isEmpty else { return }
        isLoading = true
        BusinessesService.shared.getBusinesses(
            with: .init(input: query, nextPageToken: nextPageToken)
        ) { businesses, token in
            self.businesses += businesses
            self.nextPageToken = token
            self.isLoading = false
        }
    }
}

private extension BusinessesViewController {
    enum Section {
        case main
    }
}

// MARK: UITableViewDelegate

extension BusinessesViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height * 4, !isLoading {
            getBusinesses()
        }
    }
}
