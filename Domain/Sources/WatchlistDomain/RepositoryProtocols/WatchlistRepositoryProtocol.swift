//
//  WatchlistRepositoryProtocol.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

public protocol WatchlistRepositoryProtocol: AnyObject {
    var watchlists: [Watchlist] { get }

    func fetchActiveWatchlist(completion: @escaping (WatchlistDomain.Watchlist?) -> Void)
    func addWatchlist(_ watchlist: WatchlistDomain.Watchlist)
    func addToActiveWatchlist(symbol: String)
    func remove(watchlist: Watchlist)
    func setActive(id: String)
}
