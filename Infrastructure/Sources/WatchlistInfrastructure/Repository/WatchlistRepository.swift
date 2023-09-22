//
//  WatchlistRepository.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import WatchlistDomain

final class WatchlistRepository: WatchlistRepositoryProtocol {
    var watchlists: [WatchlistDomain.Watchlist] {
        database.watchlists
    }

    private let database: WatchlistDatabaseProtocol
    private let restService: WatchlistRestServiceProtocol

    init(database: WatchlistDatabaseProtocol, restService: WatchlistRestServiceProtocol) {
        self.database = database
        self.restService = restService
    }

    func fetchActiveWatchlist(completion: @escaping (WatchlistDomain.Watchlist?) -> Void) {
        guard let activeWatchlist = database.activeWatchlist else {
            completion(nil)
            return
        }

        restService.refresh(watchlist: activeWatchlist) { result in
            switch result {
            case .success(let stockDataResponse):
                var watchlist = activeWatchlist
                let quotesResponse = stockDataResponse.map({ $0.quote })
                let quotes = quotesResponse.map {
                    Quote(
                        symbol: $0.symbol,
                        bid: $0.bidPrice.map { String($0) },
                        ask: $0.askPrice.map { String($0) },
                        last: $0.latestPrice.map { String($0) }
                    )
                }
                watchlist.update(quotes: quotes)
                completion(watchlist)
            case .failure(let error):
                print(error)
                // change return type to result and return error     in result
            }
        }
    }

    // Creates new watchlist in DB and fetches current quotes
    func addWatchlist(_ watchlist: WatchlistDomain.Watchlist, completion: @escaping (WatchlistDomain.Watchlist?) -> Void) {
        database.addWatchlist(watchlist)
        database.activeWatchlist = watchlist
        fetchActiveWatchlist(completion: completion)
    }

    func addToActiveWatchlist(symbol: String) {
        database.addToActive(symbol: symbol)
    }
}

