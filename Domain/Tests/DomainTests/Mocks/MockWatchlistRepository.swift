//
//  MockWatchlistRepository.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
@testable import WatchlistDomain

final class MockWatchlistRepository: WatchlistRepositoryProtocol {
    enum WatchlistRepositoryError: Error {
        case watchlistError
    }
    
    var watchlists: [Watchlist] = []
    var mockedWatchlist: Watchlist? = nil
    var activeWatchlistId: String? = nil
    var addWatchlistCalled = false
    var addToActiveWatchlistCalled = false
    var removeFromActiveCalled = false
    var removeWatchlistCalled = false
    var setActiveCalled = false
    var setActiveID: String?
    var addWatchlistParameter: WatchlistDomain.Watchlist?
    var addToActiveWatchlistSymbol: String?
    var removeFromActiveSymbol: String?
    var removeWatchlistID: String?

    func fetchActiveWatchlist(completion: @escaping (Result<WatchlistDomain.Watchlist?, Error>) -> Void) {
        completion(.success(mockedWatchlist))
    }

    func addWatchlist(_ watchlist: WatchlistDomain.Watchlist) {
        addWatchlistCalled = true
        addWatchlistParameter = watchlist
    }

    func addToActiveWatchlist(symbol: String) {
        addToActiveWatchlistCalled = true
        addToActiveWatchlistSymbol = symbol
    }

    func removeFromActive(symbol: String) {
        removeFromActiveCalled = true
        removeFromActiveSymbol = symbol
    }

    func removeWatchlist(id: String) {
        removeWatchlistCalled = true
        removeWatchlistID = id
    }

    func setActive(id: String) {
        setActiveCalled = true
        setActiveID = id
    }
}
