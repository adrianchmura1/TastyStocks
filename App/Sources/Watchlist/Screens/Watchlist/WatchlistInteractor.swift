//
//  WatchlistInteractor.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import WatchlistDomain

final class WatchlistInteractor {
    private let getActiveWatchlistUseCase: GetActiveWatchlistUseCaseProtocol
    private let removeSymbolUseCase: RemoveSymbolUseCaseProtocol

    init(getActiveWatchlistUseCase: GetActiveWatchlistUseCaseProtocol, removeSymbolUseCase: RemoveSymbolUseCaseProtocol) {
        self.getActiveWatchlistUseCase = getActiveWatchlistUseCase
        self.removeSymbolUseCase = removeSymbolUseCase
    }

    func getActiveWatchlist(completion: @escaping (Result<Watchlist?, Error>) -> Void) {
        getActiveWatchlistUseCase.execute(completion: completion)
    }

    func removeFromActive(symbol: String) {
        removeSymbolUseCase.execute(for: symbol)
    }
}
