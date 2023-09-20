//
//  WatchlistViewController.swift
//  
//
//  Created by Adrian Chmura on 19/09/2023.
//

import UIKit
import SnapKit

final class WatchListViewController: UIViewController {
    private let viewModel: WatchListViewModel

    private var tableView: UITableView!
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

        setupTable()
        layout()

        viewModel.action = { [weak self] actionType in
            switch actionType {
            case .reload:
                self?.tableView.reloadData()
            }
        }

        viewModel.onAppear()
    }

    private func setupTable() {
        tableViewDelegate = WatchListTableViewDelegate(viewModel: viewModel)
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDelegate
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    private func layout() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
