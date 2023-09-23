//
//  WatchlistEditViewModel.swift
//  
//
//  Created by Adrian Chmura on 23/09/2023.
//

import Foundation
import WatchlistDomain

final class WatchlistEditViewModel {
    enum Action {
        case reload
        case finished
    }

    var action: ((Action) -> Void)?

    private var watchlists: [WatchlistNamePresentable] = []

    private let interactor: WatchlistEditInteractor

    init(interactor: WatchlistEditInteractor) {
        self.interactor = interactor
    }

    var numberOfWatchlists: Int {
        return watchlists.count
    }

    func onAppear() {
        reloadWatchlists()
    }

    func watchlist(at index: Int) -> WatchlistNamePresentable {
        return watchlists[index]
    }

    func addWatchlist(withName name: String) {
        interactor.add(watchlist: Watchlist(name: name))
        reloadWatchlists()
        action?(.reload)
    }

    func removeWatchlist(at index: Int) {
        watchlists.remove(at: index)
        action?(.reload)
    }

    func didSelectRow(at index: Int) {
        let presentable = watchlist(at: index)
        interactor.switchWatchlist(id: presentable.id)
        action?(.finished)
    }

    private func reloadWatchlists() {
        watchlists = interactor.watchlists.map { WatchlistNamePresentable(id: $0.id, name: $0.name) }
    }
}

final class WatchlistEditInteractor {
    var watchlists: [Watchlist] {
        getWatchlistsUseCase.execute()
    }

    private let addWatchlistUseCase: AddWatchlistUseCaseProtocol
    private let getWatchlistsUseCase: GetWatchlistsUseCaseProtocol
    private let switchWatchlistUseCase: SwitchWatchlistUseCaseProtocol

    init(
        addWatchlistUseCase: AddWatchlistUseCaseProtocol,
        getWatchlistsUseCase: GetWatchlistsUseCaseProtocol,
        switchWatchlistUseCase: SwitchWatchlistUseCaseProtocol
    ) {
        self.addWatchlistUseCase = addWatchlistUseCase
        self.getWatchlistsUseCase = getWatchlistsUseCase
        self.switchWatchlistUseCase = switchWatchlistUseCase
    }

    func add(watchlist: Watchlist) {
        addWatchlistUseCase.execute(watchlist: watchlist)
    }

    func switchWatchlist(id: String) {
        switchWatchlistUseCase.execute(for: id)
    }
}
