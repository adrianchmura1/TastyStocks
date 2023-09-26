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
        case editWatchlistsTapped
        case goToQuotes(symbol: String)
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

    private lazy var errorView: UILabel = {
        let errorView = UILabel()
        errorView.backgroundColor = .red
        errorView.textAlignment = .center
        errorView.text = "Error when loading data"
        errorView.textColor = ColorPaletteManager.shared.currentPalette.textColor
        errorView.isHidden = true
        return errorView
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

        setupNavigationBar()
        layout()

        viewModel.action = { [weak self] actionType in
            switch actionType {
            case .reload:
                self?.errorView.isHidden = true
                self?.tableView.reloadData()
            case .showLoading:
                self?.setLoading(true)
            case .hideLoading:
                self?.setLoading(false)
            case .changeNavigationTitle(let title):
                self?.navigationItem.title = title
            case .goToQuotes(let symbol):
                self?.action?(.goToQuotes(symbol: symbol))
            case .showError:
                self?.showError()
            }
        }

        viewModel.onAppear()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setPalette()
        viewModel.onAppear()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        setPalette()

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            tableView.reloadData()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.onDisappear()
    }

    private func setLoading(_ loading: Bool) {
        loadingSpinner.isHidden = !loading
        tableView.isHidden = loading
        errorView.isHidden = true
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
        view.addSubview(errorView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        loadingSpinner.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        errorView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(80)
        }
    }

    @objc
    private func addButtonTapped() {
        action?(.addQuoteTapped)
    }

    @objc
    private func watchlistsTapped() {
        action?(.editWatchlistsTapped)
    }

    private func setPalette() {
        if traitCollection.userInterfaceStyle == .dark {
            ColorPaletteManager.shared.switchToDarkMode()
        } else {
            ColorPaletteManager.shared.switchToDefault()
        }
        view.backgroundColor = ColorPaletteManager.shared.currentPalette.backgroundColor
    }

    private func showError() {
        errorView.isHidden = false
        tableView.isHidden = true
    }
}
