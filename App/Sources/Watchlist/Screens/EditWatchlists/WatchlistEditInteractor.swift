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

    var activeWatchListId: String? {
        getActiveWatchlistIdUseCase.execute()
    }

    private let addWatchlistUseCase: AddWatchlistUseCaseProtocol
    private let getWatchlistsUseCase: GetWatchlistsUseCaseProtocol
    private let switchWatchlistUseCase: SwitchWatchlistUseCaseProtocol
    private let removeWatchlistUseCase: RemoveWatchlistUseCaseProtocol
    private let getActiveWatchlistIdUseCase: GetActiveWatchlistIdUseCaseProtocol

    init(
        addWatchlistUseCase: AddWatchlistUseCaseProtocol,
        getWatchlistsUseCase: GetWatchlistsUseCaseProtocol,
        switchWatchlistUseCase: SwitchWatchlistUseCaseProtocol,
        removeWatchlistUseCase: RemoveWatchlistUseCaseProtocol,
        getActiveWatchlistIdUseCase: GetActiveWatchlistIdUseCaseProtocol
    ) {
        self.addWatchlistUseCase = addWatchlistUseCase
        self.getWatchlistsUseCase = getWatchlistsUseCase
        self.switchWatchlistUseCase = switchWatchlistUseCase
        self.removeWatchlistUseCase = removeWatchlistUseCase
        self.getActiveWatchlistIdUseCase = getActiveWatchlistIdUseCase
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
