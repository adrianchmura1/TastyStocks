//
//  WatchlistMapper.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import WatchlistDomain

struct WatchlistMapper {
    static func mapToWatchlistPresentable(watchlist: Watchlist) -> WatchlistPresentable {
        let sortedQuotes = watchlist.quotes.map { quote in
            QuoteMapper.mapToQuotePresentable(quote: quote)
        }.sorted(by: { (quote1, quote2) -> Bool in
            return quote1.symbol < quote2.symbol
        })

        return WatchlistPresentable(
            id: watchlist.id,
            name: watchlist.name,
            quotes: sortedQuotes
        )
    }
}
