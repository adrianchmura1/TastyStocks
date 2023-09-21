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
    }

    func numberOfRowsInSection(_: Int) -> Int {
        guard let currentWatchlist else { return 0 }
        return currentWatchlist.quotes.count
    }

    func quote(at index: Int) -> QuotePresentable {
        guard let currentWatchlist else {
            fatalError("Cannot access any instrument data as current watchlist is nil")
        }
        return currentWatchlist.quotes[index]
    }

    private func reloadActiveWatchlist() {
        DispatchQueue.global().async {
            self.interactor.getActiveWatchlist { [weak self] result in
                switch result {
                case .success(let watchlist):
                    guard let self else { return }
                    self.currentWatchlist = watchlist.map {
                        WatchlistPresentable(id: $0.id, name: $0.name, quotes: $0.quotes.map { quote in
                            QuotePresentable(
                                symbol: quote.symbol,
                                askPrice: quote.ask ?? "N/A",
                                bidPrice: quote.bid ?? "N/A",
                                lastPrice: quote.last ?? "N/A"
                            )
                        })
                    }
                    DispatchQueue.main.async {
                        self.action?(.reload)
                    }
                case .failure(let error):
                    print(error)
                    // TODO: Show error state
                }
            }
        }
    }
}
