//
//  WatchListViewModel.swift
//  
//
//  Created by Adrian Chmura on 19/09/2023.
//

import Foundation
import WatchlistDomain

final class WatchListViewModel {
    enum Action {
        case reload
    }

    var action: ((Action) -> Void)?

    private var currentWatchlist: WatchlistPresentable?

    private var watchlists: [Watchlist] = []

    private let getActiveWatchlistUseCase: GetActiveWatchlistUseCaseProtocol

    init(getActiveWatchlistUseCase: GetActiveWatchlistUseCaseProtocol) {
        self.getActiveWatchlistUseCase = getActiveWatchlistUseCase
    }

    func onAppear() {
        reloadActiveWatchlist()
        action?(.reload)
    }

    func numberOfRowsInSection(_: Int) -> Int {
        guard let currentWatchlist else { return 0 }
        return currentWatchlist.stocks.count
    }

    func instrument(at index: Int) -> String {
        guard let currentWatchlist else {
            fatalError("Cannot access any instrument data as current watchlist is nil")
        }
        return currentWatchlist.stocks[index]
    }

    private func reloadActiveWatchlist() {
        currentWatchlist = getActiveWatchlistUseCase.getActiveWatchlist().map {
            WatchlistPresentable(id: $0.id, stocks: $0.stocks)
        }
        action?(.reload)
    }
}
