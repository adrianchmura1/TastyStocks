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

    var numberOfWatchlists: Int {
        return watchlists.count
    }

    private let interactor: WatchlistEditInteractor

    private var watchlists: [WatchlistNamePresentable] = []

    init(interactor: WatchlistEditInteractor) {
        self.interactor = interactor
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
        let presentable = watchlist(at: index)
        interactor.removeWatchlist(id: presentable.id)
        reloadWatchlists()
        action?(.reload)
    }

    func didSelectRow(at index: Int) {
        let presentable = watchlist(at: index)
        interactor.switchWatchlist(id: presentable.id)
        action?(.finished)
    }

    func showTicker(for index: Int) -> Bool {
        let presentable = watchlist(at: index)
        return presentable.id == interactor.activeWatchListId
    }

    private func reloadWatchlists() {
        watchlists = interactor.watchlists.map { WatchlistNamePresentable(id: $0.id, name: $0.name) }
    }
}
