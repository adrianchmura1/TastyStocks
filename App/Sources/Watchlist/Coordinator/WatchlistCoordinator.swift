//
//  WatchlistCoordinator.swift
//  
//
//  Created by Adrian Chmura on 19/09/2023.
//

import UIKit
import Coordinators
import WatchlistDomain

public final class WatchlistCoordinator: Coordinator {
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinators.Coordinator] = []

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        navigationController.navigationBar.backgroundColor = .systemOrange

        let watchlistViewController = WatchListViewController(viewModel: Resolver().watchlistViewModel)

        watchlistViewController.action = { [weak self] action in
            switch action {
            case .addQuoteTapped:
                self?.goToAddQuote()
            }
        }

        navigationController.pushViewController(watchlistViewController, animated: false)
    }

    private func goToAddQuote() {
        let addQuoteViewController = AddQuoteViewController(viewModel: Resolver().addQuoteViewModel)

        addQuoteViewController.action = { [weak self] action in
            switch action {
            case .finished:
                self?.navigationController.popViewController(animated: true)
            }
        }

        navigationController.pushViewController(addQuoteViewController, animated: false)
    }
}
