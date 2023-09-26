//
//  AddQuoteViewController.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import UIKit
import SnapKit

final class AddQuoteViewController: UIViewController {
    enum Action {
        case finished
    }

    var action: ((Action) -> Void)?

    private let tableView = UITableView()
    private let searchBar = UISearchBar()

    private lazy var searchDelegate: SearchBarDelegate = {
        SearchBarDelegate(viewModel: viewModel)
    }()

    private lazy var tableDelegate: AddQuoteTableViewDelegate = {
        AddQuoteTableViewDelegate(viewModel: viewModel)
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

    private let viewModel: AddQuoteViewModel

    init(viewModel: AddQuoteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        viewModel.action = { [weak self] action in
            switch action {
            case .reload:
                self?.tableView.isHidden = false
                self?.errorView.isHidden = true
                self?.tableView.reloadData()
            case .finished:
                self?.action?(.finished)
            case .startLoading:
                self?.setLoading(true)
            case .finishLoading:
                self?.setLoading(false)
            case .showError:
                self?.showError()
            }
        }
    }

    private func setLoading(_ loading: Bool) {
        loadingSpinner.isHidden = !loading
        tableView.isHidden = loading
    }

    private func setupUI() {
        view.backgroundColor = ColorPaletteManager.shared.currentPalette.backgroundColor
        setupSearchBar()
        setupViews()
        setupSpinner()
    }

    private func setupSearchBar() {
        searchBar.placeholder = "Search for stock quotes"
        searchBar.delegate = searchDelegate
        view.addSubview(searchBar)

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
    }

    private func setupViews() {
        tableView.delegate = tableDelegate
        tableView.dataSource = tableDelegate

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        view.addSubview(errorView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        errorView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(80)
        }
    }

    private func setupSpinner() {
        view.addSubview(loadingSpinner)

        loadingSpinner.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func showError() {
        errorView.isHidden = false
        tableView.isHidden = true
    }
}

struct StockQuote: Equatable {
    let symbol: String
    let name: String
}
