//
//  WatchlistRepository.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import WatchlistDomain
import Foundation

final class WatchlistDatabase: WatchlistDatabaseProtocol {
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
