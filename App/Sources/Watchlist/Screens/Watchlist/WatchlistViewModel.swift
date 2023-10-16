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
        case showLoading
        case hideLoading
        case changeNavigationTitle(String)
        case goToQuotes(String)
        case showError
    }

    var action: ((Action) -> Void)?

    private let interactor: WatchlistInteractor

    private var timer: Timer?
    private var currentWatchlist: WatchlistPresentable?

    private let mainQueue: Queue
    private let backgroundQueue: Queue

    init(mainQueue: Queue = DefaultMainQueue(), backgroundQueue: Queue = DefaultBackgroundQueue(), interactor: WatchlistInteractor) {
        self.interactor = interactor
        self.mainQueue = mainQueue
        self.backgroundQueue = backgroundQueue
    }

    func onAppear() {
        action?(.showLoading)
        reloadActiveWatchlist()

        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
                self?.reloadActiveWatchlist()
            }
        }
    }

    func onDisappear() {
        timer?.invalidate()
        timer = nil
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

    func didSelect(row: Int) {
        action?(.goToQuotes(quote(at: row).symbol))
    }

    func deleteRowTapped(at index: Int) {
        interactor.removeFromActive(symbol: quote(at: index).symbol)
        reloadActiveWatchlist()
    }

    private var isReloading = false

    private func reloadActiveWatchlist() {
        guard !isReloading else { return }

        isReloading = true

        backgroundQueue.async {
            self.interactor.getActiveWatchlist { [weak self] result in

                self?.isReloading = false

                switch result {
                case .success(let watchlist):
                    guard let self, let watchlist else { return }

                    let mappedWatchlist = WatchlistMapper.mapToWatchlistPresentable(watchlist: watchlist)

                    mainQueue.async {
                        self.currentWatchlist = mappedWatchlist
                        self.action?(.changeNavigationTitle(mappedWatchlist.name))
                        self.action?(.reload)
                        self.action?(.hideLoading)
                    }
                case .failure:
                    self?.mainQueue.async {
                        self?.action?(.showError)
                    }
                }
            }
        }
    }
}
