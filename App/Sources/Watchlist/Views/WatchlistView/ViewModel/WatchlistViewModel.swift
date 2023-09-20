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

    private let interactor: WatchlistInteractor

    private var currentWatchlist: WatchlistPresentable?

    init(interactor: WatchlistInteractor) {
        self.interactor = interactor
    }

    func onAppear() {
        reloadActiveWatchlist()
        action?(.reload)
    }

    func numberOfRowsInSection(_: Int) -> Int {
        guard let currentWatchlist else { return 0 }
        return currentWatchlist.quotes.count
    }

    func quote(at index: Int) -> String {
        guard let currentWatchlist else {
            fatalError("Cannot access any instrument data as current watchlist is nil")
        }
        return currentWatchlist.quotes[index].symbol
    }

    private func reloadActiveWatchlist() {
        currentWatchlist = interactor.getActiveWatchlist().map {
            WatchlistPresentable(id: $0.id, name: $0.name, quotes: $0.quotes.map { quote in
                QuotePresentable(symbol: quote.symbol, askPrice: "0", bidPrice: "0", lastPrice: "0")
            })
        }
        action?(.reload)
    }
}
