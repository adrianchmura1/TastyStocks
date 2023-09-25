//
//  MockWatchlistRestService.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
import WatchlistDomain
@testable import WatchlistInfrastructure

final class MockWatchlistRestService: WatchlistRestServiceProtocol {
    var refreshWatchlist: Watchlist?
    var refreshResult: Result<[StockDataResponse], Error>?

    func refresh(watchlist: Watchlist, completion: @escaping (Result<[StockDataResponse], Error>) -> Void) {
        refreshWatchlist = watchlist
        if let result = refreshResult {
            completion(result)
        }
    }
}
