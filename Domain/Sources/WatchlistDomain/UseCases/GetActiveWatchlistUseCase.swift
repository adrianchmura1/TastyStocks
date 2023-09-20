//
//  GetActiveWatchlistUseCase.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

public protocol GetActiveWatchlistUseCaseProtocol: AnyObject {
    func getActiveWatchlist() -> Watchlist?
}

final class GetActiveWatchlistUseCase: GetActiveWatchlistUseCaseProtocol {
    private let repository: WatchlistRepositoryProtocol

    init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    func getActiveWatchlist() -> Watchlist? {
        repository.activeWatchlist
    }
}
