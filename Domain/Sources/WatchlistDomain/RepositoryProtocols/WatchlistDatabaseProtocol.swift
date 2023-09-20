//
//  File.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

public protocol WatchlistDatabaseProtocol: AnyObject {
    var watchlists: [Watchlist] { get }
    var activeWatchlist: Watchlist? { get set }

    func addWatchlist(_ watchlist: Watchlist)
}
