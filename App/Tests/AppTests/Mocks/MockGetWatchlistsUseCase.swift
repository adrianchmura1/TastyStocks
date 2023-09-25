//
//  MockGetWatchlistsUseCase.swift
//  
//
//  Created by Adrian Chmura on 26/09/2023.
//

import Foundation
import WatchlistDomain

class MockGetWatchlistsUseCase: GetWatchlistsUseCaseProtocol {
    var watchlists: [Watchlist] = []
    var isCalled = false

    func execute() -> [Watchlist] {
        isCalled = true
        return watchlists
    }
}
