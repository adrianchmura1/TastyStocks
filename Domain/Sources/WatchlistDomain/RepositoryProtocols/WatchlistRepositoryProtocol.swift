//
//  WatchlistRepositoryProtocol.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

public protocol WatchlistRepositoryProtocol: AnyObject {
    var watchlists: [Watchlist] { get }
    var activeWatchlistId: String? { get }

    func fetchActiveWatchlist(completion: @escaping (Result<WatchlistDomain.Watchlist?, Error>) -> Void)
    func addWatchlist(_ watchlist: WatchlistDomain.Watchlist)
    func addToActiveWatchlist(symbol: String)
    func removeFromActive(symbol: String)
    func removeWatchlist(id: String)
    func setActive(id: String)
}
