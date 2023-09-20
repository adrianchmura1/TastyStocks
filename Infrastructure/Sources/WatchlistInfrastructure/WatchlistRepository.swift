//
//  File.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import WatchlistDomain

final class WatchlistRepository: WatchlistRepositoryProtocol {
    var activeWatchlist: Watchlist? {
        watchlists.first(where: {
            $0.id == "2"
        })
    }

    var watchlists: [Watchlist] {
        [
            .init(id: "1", stocks: ["AAPL", "GOOGL", "TSLA", "AAPL Call", "GOOGL Put", "Gold", "Crude Oil"]),
            .init(id: "2", stocks: ["AAPL", "TSLA", "AAPL Call", "GOOGL Put", "Crude Oil"]),
            .init(id: "3", stocks: ["AAPL", "GOOGL", "Gold", "Meta"])
        ]
    }
}
