//
//  WatchlistEditInteractor.swift
//  
//
//  Created by Adrian Chmura on 23/09/2023.
//

import WatchlistDomain

final class WatchlistEditInteractor {
    var watchlists: [Watchlist] {
        getWatchlistsUseCase.execute()
    }

    private let addWatchlistUseCase: AddWatchlistUseCaseProtocol
    private let getWatchlistsUseCase: GetWatchlistsUseCaseProtocol
    private let switchWatchlistUseCase: SwitchWatchlistUseCaseProtocol
    private let removeWatchlistUseCase: RemoveWatchlistUseCaseProtocol

    init(
        addWatchlistUseCase: AddWatchlistUseCaseProtocol,
        getWatchlistsUseCase: GetWatchlistsUseCaseProtocol,
        switchWatchlistUseCase: SwitchWatchlistUseCaseProtocol,
        removeWatchlistUseCase: RemoveWatchlistUseCaseProtocol
    ) {
        self.addWatchlistUseCase = addWatchlistUseCase
        self.getWatchlistsUseCase = getWatchlistsUseCase
        self.switchWatchlistUseCase = switchWatchlistUseCase
        self.removeWatchlistUseCase = removeWatchlistUseCase
    }

    func add(watchlist: Watchlist) {
        addWatchlistUseCase.execute(watchlist: watchlist)
    }

    func switchWatchlist(id: String) {
        switchWatchlistUseCase.execute(for: id)
    }

    func removeWatchlist(id: String) {
        removeWatchlistUseCase.execute(for: id)
    }
}
