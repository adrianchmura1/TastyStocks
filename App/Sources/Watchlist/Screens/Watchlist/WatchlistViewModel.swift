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
    }

    var action: ((Action) -> Void)?

    private let interactor: WatchlistInteractor

    private var timer: Timer?
    private var currentWatchlist: WatchlistPresentable?

    init(interactor: WatchlistInteractor) {
        self.interactor = interactor
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

    private func reloadActiveWatchlist() {
        DispatchQueue.global().async {
            self.interactor.getActiveWatchlist { [weak self] result in
                switch result {
                case .success(let watchlist):
                    guard let self, let watchlist else { return }

                    let mappedWatchlist = WatchlistMapper.mapToWatchlistPresentable(watchlist: watchlist)

                    DispatchQueue.main.async {
                        self.currentWatchlist = mappedWatchlist
                        self.action?(.changeNavigationTitle(mappedWatchlist.name))
                        self.action?(.reload)
                        self.action?(.hideLoading)
                    }
                case .failure(let error):
                    print(error)
                    // TODO: Show error state
                }
            }
        }
    }
}
