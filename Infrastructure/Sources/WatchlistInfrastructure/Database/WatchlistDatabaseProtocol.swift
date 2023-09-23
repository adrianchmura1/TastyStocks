//
//  File.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import WatchlistDomain

protocol WatchlistDatabaseProtocol: AnyObject {
    var watchlists: [Watchlist] { get }
    var activeWatchlist: Watchlist? { get }
    var activeWatchlistId: String? { get }

    func addWatchlist(_ watchlist: Watchlist)
    func addToActive(symbol: String)
    func removeWatchlist(id: String)
    func setActive(id: String)
}
