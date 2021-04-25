//
//  AlbumDetailViewController.swift
//  IOS-Example
//
//  Created by Александр Арсенюк on 25.04.2021.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let albumDetailView = AlbumDetailView()
    
    // MARK: - Public properties
    
    var presenter: AlbumDetailViewOutput?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = albumDetailView
        setupNavigation()
        setupDelegates()
        presenter?.loadData(completion: nil)
    }
    
    // MARK: - Private methods
    
    private func setupNavigation() {
        let albumId = presenter?.albumNumber ?? -1
        navigationItem.title = "Album #\(albumId)"
    }
    
    private func setupDelegates() {
        albumDetailView.tableView.dataSource = self
        albumDetailView.tableView.delegate = self
        albumDetailView.refreshControlDelegate = self
    }
    
}

extension AlbumDetailViewController: AlbumDetailViewInput {
    
    func reloadData() {
        albumDetailView.tableView.reloadData()
    }
    
    func setupAnimating(isAnimating: Bool) {
        isAnimating
            ? albumDetailView.activityIndicator.startAnimating()
            : albumDetailView.activityIndicator.stopAnimating()
    }
    
}

extension AlbumDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.posts.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self)) as? PostCell,
              let model = presenter?.posts[indexPath.row] else { return UITableViewCell() }
        cell.configure(with: model)
        return cell
    }

}

extension AlbumDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.postPressed(at: indexPath)
    }

}

extension AlbumDetailViewController: RefreshControlDelegate {

    func refreshData(completion: @escaping () -> Void) {
        presenter?.loadData(completion: completion)
    }

}

