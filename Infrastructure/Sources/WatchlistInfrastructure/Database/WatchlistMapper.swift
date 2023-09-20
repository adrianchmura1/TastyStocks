//
//  WatchlistMapper.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import WatchlistDomain

final class WatchlistMapper {
    static func mapToDTO(_ watchlist: Watchlist) -> WatchlistDTO {
        return WatchlistDTO(id: watchlist.id, name: watchlist.name, quotes: watchlist.quotes.map {
            QuoteDTO(symbol: $0.symbol, bid: $0.bid, ask: $0.ask, last: $0.last)
        })
    }

    static func mapToWatchlist(_ dto: WatchlistDTO) -> Watchlist {
        return Watchlist(id: dto.id, name: dto.name, quotes: dto.quotes.map {
            Quote(symbol: $0.symbol, bid: $0.bid, ask: $0.ask, last: $0.last)
        })
    }
}
