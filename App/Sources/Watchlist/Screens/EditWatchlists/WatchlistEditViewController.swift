//
//  WatchlistEditViewController.swift
//  
//
//  Created by Adrian Chmura on 22/09/2023.
//

import WatchlistDomain
import UIKit

final class WatchlistEditViewController: UIViewController {
    enum Action {
        case finished
    }

    var action: ((Action) -> Void)?

    private let viewModel: WatchlistEditViewModel
    private let tableView = UITableView()

    init(viewModel: WatchlistEditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Watchlists"

        viewModel.action = { [weak self] action in
            switch action {
            case .reload:
                self?.tableView.reloadData()
            case .finished:
                self?.action?(.finished)
            }
        }

        viewModel.onAppear()

        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WatchlistCell")

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func addButtonTapped() {
        let alertController = UIAlertController(title: "Add Watchlist", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter Watchlist Name"
        }
        let addAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            if let name = alertController.textFields?.first?.text, !name.isEmpty {
                self?.viewModel.addWatchlist(withName: name)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension WatchlistEditViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfWatchlists
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchlistCell", for: indexPath)
        let watchlist = viewModel.watchlist(at: indexPath.row)
        cell.textLabel?.text = watchlist.name
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeWatchlist(at: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath.row)
    }
}
