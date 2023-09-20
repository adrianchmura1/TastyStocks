//
//  File.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import WatchlistDomain

//final class WatchlistRepository: WatchlistRepositoryProtocol {
//    var activeWatchlist: Watchlist? {
//        watchlists.first(where: {
//            $0.id == "2"
//        })
//    }
//
//    var watchlists: [Watchlist] {
//        [
//            .init(id: "1", stocks: ["AAPL", "GOOGL", "TSLA", "AAPL Call", "GOOGL Put", "Gold", "Crude Oil"]),
//            .init(id: "2", stocks: ["AAPL", "TSLA", "AAPL Call", "GOOGL Put", "Crude Oil"]),
//            .init(id: "3", stocks: ["AAPL", "GOOGL", "Gold", "Meta"])
//        ]
//    }
//}

import Foundation

final class WatchlistRepository: WatchlistRepositoryProtocol {
    private let watchlistsKey = "Watchlists"
    private let activeWatchlistIDKey = "ActiveWatchlistID"

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    var watchlists: [Watchlist] {
        get {
            if let data = userDefaults.data(forKey: watchlistsKey),
               let watchlistDTOs = try? JSONDecoder().decode([WatchlistDTO].self, from: data) {
                // Map WatchlistDTOs to Watchlists using WatchlistMapper
                return watchlistDTOs.map { WatchlistMapper.mapToWatchlist($0) }
            }
            return []
        }
        set {
            let watchlistDTOs = newValue.map { WatchlistMapper.mapToDTO($0) }
            if let data = try? JSONEncoder().encode(watchlistDTOs) {
                userDefaults.set(data, forKey: watchlistsKey)
            }
        }
    }

    var activeWatchlist: Watchlist? {
        get {
            let activeWatchlistID = userDefaults.string(forKey: activeWatchlistIDKey)
            return watchlists.first { $0.id == activeWatchlistID }
        }
        set {
            userDefaults.set(newValue?.id, forKey: activeWatchlistIDKey)
        }
    }

    func addWatchlist(_ watchlist: Watchlist) {
        var updatedWatchlists = watchlists
        updatedWatchlists.append(watchlist)
        watchlists = updatedWatchlists
    }
}
