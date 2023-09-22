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
                self?.tableView.reloadData()
            case .finished:
                self?.action?(.finished)
            }
        }
    }

    private func setupUI() {
        view.backgroundColor = .white
        setupSearchBar()
        setupTableView()
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

    private func setupTableView() {
        tableView.delegate = tableDelegate
        tableView.dataSource = tableDelegate
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

struct StockQuote {
    let symbol: String
    let name: String
}

let dummyStockQuotes: [StockQuote] = [
    StockQuote(symbol: "TSLA", name: "Tesla, Inc."),
    StockQuote(symbol: "FB", name: "Meta Platforms, Inc."),
    StockQuote(symbol: "NVDA", name: "NVIDIA Corporation"),
    StockQuote(symbol: "BRK.B", name: "Berkshire Hathaway Inc."),
    StockQuote(symbol: "JPM", name: "JPMorgan Chase & Co."),
    StockQuote(symbol: "V", name: "Visa Inc."),
    StockQuote(symbol: "JNJ", name: "Johnson & Johnson"),
    StockQuote(symbol: "PG", name: "Procter & Gamble Co."),
    StockQuote(symbol: "UNH", name: "UnitedHealth Group Inc."),
    StockQuote(symbol: "BAC", name: "Bank of America Corp."),
    StockQuote(symbol: "GOOG", name: "Alphabet Inc."),
    StockQuote(symbol: "MA", name: "Mastercard Inc."),
    StockQuote(symbol: "AAPL", name: "Apple Inc."),
    StockQuote(symbol: "CSCO", name: "Cisco Systems, Inc."),
    StockQuote(symbol: "INTC", name: "Intel Corporation"),
    StockQuote(symbol: "T", name: "AT&T Inc."),
    StockQuote(symbol: "DIS", name: "The Walt Disney Company"),
    StockQuote(symbol: "KO", name: "The Coca-Cola Company"),
    StockQuote(symbol: "PEP", name: "PepsiCo, Inc."),
    StockQuote(symbol: "WMT", name: "Walmart Inc.")
]
