//
//  AddWatchlistUseCaseProtocol.swift
//  
//
//  Created by Adrian Chmura on 23/09/2023.
//

import Foundation

public protocol AddWatchlistUseCaseProtocol: AnyObject {
    func execute(watchlist: Watchlist)
}

final class AddWatchlistUseCase: AddWatchlistUseCaseProtocol {
    private let watchlistRepository: WatchlistRepositoryProtocol

    init(watchlistRepository: WatchlistRepositoryProtocol) {
        self.watchlistRepository = watchlistRepository
    }

    func execute(watchlist: Watchlist) {
        watchlistRepository.addWatchlist(watchlist)
    }
}
