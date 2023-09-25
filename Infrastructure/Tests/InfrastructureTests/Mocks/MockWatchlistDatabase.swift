//
//  MockWatchlistDatabase.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
import WatchlistDomain
@testable import WatchlistInfrastructure

final class MockWatchlistDatabase: WatchlistDatabaseProtocol {
    var watchlists: [Watchlist] = []
    var activeWatchlist: Watchlist?
    var activeWatchlistId: String?

    func addWatchlist(_ watchlist: Watchlist) {
        watchlists.append(watchlist)
        activeWatchlist = watchlist
    }

    func addToActive(symbol: String) {
        activeWatchlist?.add(quote: Quote(symbol: symbol))
    }

    func removeFromActive(symbol: String) {
        activeWatchlist?.remove(symbol: symbol)
    }

    func removeWatchlist(id: String) {
        watchlists.removeAll { $0.id == id }
    }

    func setActive(id: String) {
        activeWatchlistId = id
        activeWatchlist = watchlists.first { $0.id == id }
    }
}
