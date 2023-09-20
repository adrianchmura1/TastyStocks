//
//  WatchlistMapper.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import WatchlistDomain

final class WatchlistMapper {
    static func mapToDTO(_ watchlist: Watchlist) -> WatchlistDTO {
        return WatchlistDTO(id: watchlist.id, stocks: watchlist.stocks)
    }

    static func mapToWatchlist(_ dto: WatchlistDTO) -> Watchlist {
        return Watchlist(id: dto.id, stocks: dto.stocks)
    }
}
