//
//  AppCoordinator.swift
//  TastyStocks
//
//  Created by Adrian Chmura on 19/09/2023.
//

import Coordinators
import Watchlist
import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let watchlist = WatchlistCoordinator(navigationController: navigationController)
        childCoordinators.append(watchlist)
        watchlist.start()
    }
}
