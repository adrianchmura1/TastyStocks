//
//  GetActiveWatchlistUseCase.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

public protocol GetActiveWatchlistUseCaseProtocol: AnyObject {
    func getActiveWatchlist() -> Watchlist?
}

final class GetActiveWatchlistUseCase: GetActiveWatchlistUseCaseProtocol {
    private static let initialWatchlistName = "My first list"

    private let repository: WatchlistDatabaseProtocol

    init(repository: WatchlistDatabaseProtocol) {
        self.repository = repository
    }

    func getActiveWatchlist() -> Watchlist? {
        if let activeWatchlist = repository.activeWatchlist {
            return activeWatchlist
        } else {
            let quotes = [Quote(symbol: "AAPL"), Quote(symbol: "MSFT"), Quote(symbol: "GOOG")]
            let initialWatchlist = Watchlist(id: UUID().uuidString, name: Self.initialWatchlistName, quotes: quotes)
            repository.addWatchlist(initialWatchlist)
            repository.activeWatchlist = initialWatchlist
            return initialWatchlist
        }
    }
}
