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

    var activeWatchlistId: String? {
        database.activeWatchlistId
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

        guard !activeWatchlist.quotes.isEmpty else {
            completion(activeWatchlist)
            return
        }

        restService.refresh(watchlist: activeWatchlist) { result in
            switch result {
            case .success(let stockDataResponse):
                var watchlist = activeWatchlist
                let quotesResponse = stockDataResponse.map({ $0.quote })
                let mapper = QuoteResponseMapper()
                let quotes = quotesResponse.map {
                    mapper.map(quoteResponse: $0)
                }
                watchlist.update(quotes: quotes)
                completion(watchlist)
            case .failure(let error):
                print(error)
                // change return type to result and return error     in result
            }
        }
    }

    func addWatchlist(_ watchlist: WatchlistDomain.Watchlist) {
        database.addWatchlist(watchlist)
        database.setActive(id: watchlist.id)
    }

    func addToActiveWatchlist(symbol: String) {
        database.addToActive(symbol: symbol)
    }

    func removeFromActive(symbol: String) {
        database.removeFromActive(symbol: symbol)
    }

    func removeWatchlist(id: String) {
        database.removeWatchlist(id: id)
    }

    func setActive(id: String) {
        database.setActive(id: id)
    }
}
