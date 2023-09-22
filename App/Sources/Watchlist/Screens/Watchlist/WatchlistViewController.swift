//
//  WatchlistViewController.swift
//  
//
//  Created by Adrian Chmura on 19/09/2023.
//

import UIKit
import SnapKit

final class WatchListViewController: UIViewController {
    enum Action {
        case addQuoteTapped
    }

    var action: ((Action) -> Void)?

    private let viewModel: WatchListViewModel

    private lazy var tableView: UITableView = {
        tableViewDelegate = WatchListTableViewDelegate(viewModel: viewModel)
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDelegate
        tableView.register(WatchlistTableViewQuoteCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()

    private lazy var loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .gray
        spinner.hidesWhenStopped = true
        return spinner
    }()

    private var tableViewDelegate: WatchListTableViewDelegate?

    init(viewModel: WatchListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupNavigationBar()
        layout()

        viewModel.action = { [weak self] actionType in
            switch actionType {
            case .reload:
                self?.tableView.reloadData()
            case .showLoading:
                self?.setLoading(true)
            case .hideLoading:
                self?.setLoading(false)
            }
        }

        viewModel.onAppear()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.onDisappear()
    }

    private func setLoading(_ loading: Bool) {
        loadingSpinner.isHidden = !loading
        tableView.isHidden = loading
    }

    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        let switchWatchlist = UIBarButtonItem(title: "Watchlists", style: .plain, target: self, action: #selector(watchlistsTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem  = switchWatchlist
    }

    private func layout() {
        view.addSubview(tableView)
        view.addSubview(loadingSpinner)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        loadingSpinner.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    @objc
    private func addButtonTapped() {
        action?(.addQuoteTapped)
    }

    @objc
    private func watchlistsTapped() {
        print("addButtonTapped")
    }
}
