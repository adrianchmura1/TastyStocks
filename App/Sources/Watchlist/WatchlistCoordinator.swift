//
//  WatchlistCoordinator.swift
//  
//
//  Created by Adrian Chmura on 19/09/2023.
//

import UIKit
import Coordinators

public final class WatchlistCoordinator: Coordinator {
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinators.Coordinator] = []

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        // TODO: Implement watchlist
        print("[WatchlistCoordinator] start")
    }
}
