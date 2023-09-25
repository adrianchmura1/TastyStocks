//
//  MockAddWatchlistUseCase.swift
//  
//
//  Created by Adrian Chmura on 26/09/2023.
//

import Foundation
import WatchlistDomain

class MockAddWatchlistUseCase: AddWatchlistUseCaseProtocol {
    var addedWatchlist: Watchlist?
    var isCalled = false

    func execute(watchlist: Watchlist) {
        isCalled = true
        addedWatchlist = watchlist
    }
}
