//
//  WatchlistInteractor.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import WatchlistDomain

final class WatchlistInteractor {
    private let getActiveWatchlistUseCase: GetActiveWatchlistUseCaseProtocol

    init(getActiveWatchlistUseCase: GetActiveWatchlistUseCaseProtocol) {
        self.getActiveWatchlistUseCase = getActiveWatchlistUseCase
    }

    func getActiveWatchlist(completion: @escaping (Result<Watchlist?, Error>) -> Void) {
        getActiveWatchlistUseCase.execute(completion: completion)
    }
}
